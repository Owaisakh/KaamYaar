import 'package:flutter_test/flutter_test.dart';
import 'package:kaamyaar/features/auth/domain/user_model.dart';

void main() {
  group('UserModel Serialization/Deserialization', () {
    test('should correctly deserialize a customer JSON', () {
      final json = {
        'id': 'uuid-1234',
        'phone': '+923001234567',
        'name': 'John Doe',
        'role': 'customer',
      };

      final user = UserModel.fromJson(json);

      expect(user.id, 'uuid-1234');
      expect(user.phone, '+923001234567');
      expect(user.name, 'John Doe');
      expect(user.role, UserRole.customer);
    });

    test('should correctly deserialize a worker JSON', () {
      final json = {
        'id': 'uuid-5678',
        'phone': '+923001234568',
        'name': 'Jane Smith',
        'role': 'worker',
      };

      final user = UserModel.fromJson(json);

      expect(user.id, 'uuid-5678');
      expect(user.phone, '+923001234568');
      expect(user.name, 'Jane Smith');
      expect(user.role, UserRole.worker);
    });

    test('should correctly deserialize an admin JSON', () {
      final json = {
        'id': 'uuid-admin',
        'phone': '+923001234569',
        'name': 'Admin User',
        'role': 'admin',
      };

      final user = UserModel.fromJson(json);

      expect(user.id, 'uuid-admin');
      expect(user.phone, '+923001234569');
      expect(user.name, 'Admin User');
      expect(user.role, UserRole.admin);
    });

    test('should correctly serialize a user to JSON', () {
      const user = UserModel(
        id: 'uuid-123',
        phone: '123456',
        name: 'Test',
        role: UserRole.customer,
      );

      final json = user.toJson();

      expect(json['id'], 'uuid-123');
      expect(json['phone'], '123456');
      expect(json['name'], 'Test');
      expect(json['role'], 'customer');
    });
  });
}
