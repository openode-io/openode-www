# External Services and Persistence

You can connect to external services, for example for key-value storage, persistence or database, queues, etc.
Typically this is done by passing configurations via [environment variables](/docs/platform/env_vars.md).

## Persistence

For persistence, it is recommended to use an external remote service, for example SQL databases, NoSQL databases, remote file storage (like S3), etc. Note that if you would like to use sqlite, you can probably instead use an SQL database such as PostgreSQL and most of your queries will work.

Some examples of cheap/free persistence services:

- PostgreSQL: [https://www.elephantsql.com/plans.html](https://www.elephantsql.com/plans.html)
- MongoDB: [https://mlab.com/plans/pricing/](https://mlab.com/plans/pricing/)
- neo4j, a graph database: [https://neo4j.com/pricing/](https://neo4j.com/pricing/)

Feel free to let us know about your experiences with them using opeNode. We can update this list.