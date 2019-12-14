abstract class BaseDB<T> {
  ///Get all in database.
  Future<List<Map<String, dynamic>>> getAllInDb();

  /// Gets entries from database with one filters.
  Future<List<Map<String, dynamic>>> getWithOneParameter<A>(A filterOne);

  /// Gets entries from database with two filters.
  Future<List<Map<String, dynamic>>> getWithTwoParameters<A, B>(A filterOne, B filterTwo);

  /// Gets entries from database with three filters.
  Future<List<Map<String, dynamic>>> getWithThreeParameters<A, B, C>(A filterOne, B filterTwo, C filterThree);

  /// Update object in database.
  Future<int> update(T object);

  /// Insert object to database.
  Future<void> insert(T object);

  /// Deletes an entry in database by ID.
  Future<int> deleteById(int id);

  /// Deletes an entry in database by string.
  Future<int> deleteByString(String s);

  /// Given a list of transactions, executes them in SQFLite.
  Future<void> batchJob(List<T> object);
}
