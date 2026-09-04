enum UserRole {
  parent,
  teacher,
  child;

  String get label {
    switch (this) {
      case UserRole.parent:
        return 'Parent';
      case UserRole.teacher:
        return 'Teacher';
      case UserRole.child:
        return 'Child';
    }
  }
}
