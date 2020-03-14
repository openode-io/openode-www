# Persisted Storage

It is worth noting that by default deployments are **immutable**, that is, if you 
write some data to a file and then redeploy, the written data will be lost. It is
however possible to attach an **external persistent storage area**. This doc will guide you
to create such a persistent area.

## Defining the storage size

The first thing to do is to configure the specific persisted storage size.

#### Administration Dashboard

Persistence can be managed via the administration, from the instances list, click on Settings > Persistence.

#### CLI

By default, as there is no persistence, the persisted storage size is set to 0.

Using the command line interface (CLI), you can increase the storage size in GB:

    openode increase-storage <size>

where *<size>* is the number of persisted storage size in GB (example 3).

## Defining the storage area

Next you need to at least add a storage area folder, where you will be able to read/write
your persisted data.

#### Administration Dashboard

Persistence can be managed via the administration, from the instances list, click on Settings > Persistence.

#### CLI

You can set a storage area with the following command:

      openode add-storage-area <folder path>

where *<folder path>* corresponds to the folder full path, example */opt/data/*.
And so if you run openode add-storage-area /opt/data/, then from your application you
will be able to read and write to the folder /opt/data/, for example /opt/data/db.sqlite
if you are having an SQLite database. 

#### 

## Deploy

When you redeploy your instance, it will take care to allocate the proper persisted storage.
TODO link to deploy documentation

## Destroying/resetting your persisted storage

You can reset/destroy your persisted storage. **Warning**, this will permanently erase
your existing persisted data. Note that it will also set the storage size to 0 GB.

#### Administration Dashboard

Persistence can be managed via the administration, from the instances list, click on Settings > Persistence.

#### CLI

Using the CLI, you can simply run the following command:

    openode destroy-storage