use std::sync::Arc;
use surrealdb::{engine::any::Any, sql::Id, Surreal};
use tokio::{runtime::Runtime, sync::Semaphore, task::JoinSet};

use crate::sdb_benches::sdk::Record;

pub struct Read {
	runtime: &'static Runtime,
	table_name: String,
}

impl Read {
	pub fn new(runtime: &'static Runtime) -> Self {
		Self {
			runtime,
			table_name: format!("table_{}", Id::rand().to_raw()),
		}
	}
}

impl super::Routine for Read {
	fn setup(&self, client: &'static Surreal<Any>, num_ops: usize) {
		self.runtime.block_on(async {
			// Spawn one task for each operation
			let mut tasks = JoinSet::default();
			// Create one record at a time to avoid transaction conflicts
			// TODO(rushmore) handle this internally so we don't have to run one write at a time
			let semaphore = Arc::new(Semaphore::new(1));
			for task_id in 0..num_ops {
				let semaphore = semaphore.clone();
				let table_name = self.table_name.clone();

				tasks.spawn(async move {
					let permit = semaphore.acquire().await.unwrap();
					let _: Option<Record> = client
						.create((table_name, task_id as i64))
						.content(Record {
							field: Id::rand(),
						})
						.await
						.expect("[setup] create record failed")
						.expect("[setup] the create operation returned None");
					drop(permit);
				});
			}

			while let Some(task) = tasks.join_next().await {
				task.unwrap();
			}
		});
	}

	fn run(&self, client: &'static Surreal<Any>, num_ops: usize) {
		self.runtime.block_on(async {
			// Spawn one task for each operation
			let mut tasks = JoinSet::default();
			for task_id in 0..num_ops {
				let table_name = self.table_name.clone();

				tasks.spawn(async move {
					let _: Option<Record> = criterion::black_box(
						client
							.select((table_name, task_id as i64))
							.await
							.expect("[run] select operation failed")
							.expect("[run] the select operation returned None"),
					);
				});
			}

			while let Some(task) = tasks.join_next().await {
				task.unwrap();
			}
		});
	}

	fn cleanup(&self, client: &'static Surreal<Any>, _num_ops: usize) {
		self.runtime.block_on(async {
			client
				.query(format!("REMOVE table {}", self.table_name))
				.await
				.expect("[cleanup] remove table failed")
				.check()
				.unwrap();
		});
	}
}
