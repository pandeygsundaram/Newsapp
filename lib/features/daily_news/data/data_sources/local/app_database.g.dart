// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ArticleDao? _articleDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `article` (`id` INTEGER, `author` TEXT, `title` TEXT, `description` TEXT, `url` TEXT, `urlToImage` TEXT, `publishedAt` TEXT, `content` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ArticleDao get articleDao {
    return _articleDaoInstance ??= _$ArticleDao(database, changeListener);
  }
}

class _$ArticleDao extends ArticleDao {
  _$ArticleDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _articleModelInsertionAdapter = InsertionAdapter(
            database,
            'article',
            (ArticleModel item) => <String, Object?>{
                  'id': item.id,
                  'author': item.author,
                  'title': item.title,
                  'description': item.description,
                  'url': item.url,
                  'urlToImage': item.urlToImage,
                  'publishedAt': item.publishedAt,
                  'content': item.content
                }),
        _articleModelDeletionAdapter = DeletionAdapter(
            database,
            'article',
            ['id'],
            (ArticleModel item) => <String, Object?>{
                  'id': item.id,
                  'author': item.author,
                  'title': item.title,
                  'description': item.description,
                  'url': item.url,
                  'urlToImage': item.urlToImage,
                  'publishedAt': item.publishedAt,
                  'content': item.content
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ArticleModel> _articleModelInsertionAdapter;

  final DeletionAdapter<ArticleModel> _articleModelDeletionAdapter;

  @override
  Future<List<ArticleModel>> getArticle() async {
    return _queryAdapter.queryList('SELECT * FROM article',
        mapper: (Map<String, Object?> row) => ArticleModel(
            id: row['id'] as int?,
            title: row['title'] as String?,
            description: row['description'] as String?,
            content: row['content'] as String?,
            author: row['author'] as String?,
            url: row['url'] as String?,
            urlToImage: row['urlToImage'] as String?,
            publishedAt: row['publishedAt'] as String?));
  }

  @override
  Future<void> insertArticle(ArticleModel article) async {
    await _articleModelInsertionAdapter.insert(
        article, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteArticle(ArticleModel article) async {
    await _articleModelDeletionAdapter.delete(article);
  }
}
