abstract class BaseDB<T> {
  Future<List<Map<String, dynamic>>> getAllInDb();

  Future<List<Map<String, dynamic>>> getWithOneParameter<A>(A filterOne);

  /// Gets all user transactions between two dates that is in millisecondsFromEpoch.
  Future<List<Map<String, dynamic>>> getWithTwoParameters<A, B>(A filterOne, B filterTwo);

  /// Gets all transactions from a particular category and date.
  Future<List<Map<String, dynamic>>> getWithThreeParameters<A, B, C>(A filterOne, B filterTwo, C filterThree);

  Future<int> update(T object);

  Future<void> insert(T object);

  /// Deletes an entry in database by ID.
  Future<int> deleteById(int id);

  /// Deletes an entry in database by string.
  Future<int> deleteByString(String s);
}
