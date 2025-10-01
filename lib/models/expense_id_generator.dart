class ExpenseIdGenerator {
  static int _id = 0;

  static int getNextId() {
    _id++;
    return _id;
  }
}
