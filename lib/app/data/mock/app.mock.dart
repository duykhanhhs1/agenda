import 'package:ru_agenda/app/data/models/assignment.model.dart';
import 'package:ru_agenda/app/data/models/class.model.dart';
import 'package:ru_agenda/app/data/models/user.model.dart';

class AppMock {
  static LoginResponseModel loginResponse = LoginResponseModel(
    token: 'zxc',
    refreshToken: 'refresh',
    user: UserModel(
      email: 'duykhanhhs1@gmail.com',
      fullName: 'Duy Khanh Tran',
      userNo: 123,
    ),
  );
  static List<ClassModel> classes = [
    ClassModel(
      courseTitle: 'ITEC 324',
      dateMeet: DateTime(2021, 10, 10),
      instructorName: 'Kuvempu',
    ),
    ClassModel(
      courseTitle: 'ITEC 325',
      dateMeet: DateTime(2021, 10, 10),
      instructorName: 'Kuvempu',
    ),
    ClassModel(
      courseTitle: 'ITEC 326',
      dateMeet: DateTime(2021, 10, 10),
      instructorName: 'Kuvempu',
    ),
  ];

  static List<AssignmentModel> assignments = [
    AssignmentModel(
      assignmentName: 'Requirements Document',
      dueDate: DateTime(2020, 10, 05),
      className: 'ITEC 324',
      numberNoticeDay: 3,
      assignmentDesc:
          'Sequi ducimus vel. In aperiam non odio adipisci perferendis magnam ducimus alias in. Aut blanditiis ut sequi deleniti amet ipsa. Molestias ipsa architecto consequatur aspernatur. Possimus voluptatem ipsam rerum. Fugit doloremque ut delectus voluptas ipsa ut porro eos nobis. Laboriosam rem esse neque quia. Praesentium omnis porro. Quod dolorem corrupti culpa enim. Ab eos voluptas. Nam ex deserunt sapiente aliquam ipsum. Qui est enim autem velit officiis. Voluptatem similique pariatur facere ut vel perspiciatis rerum sed.',
    ),
    AssignmentModel(
      assignmentName: 'Requirements Document',
      dueDate: DateTime(2020, 10, 05),
      className: 'ITEC 324',
      numberNoticeDay: 3,
      assignmentDesc:
          'Error explicabo aut consequuntur. In officiis neque et. Iure non ut. Eos et eos eius non incidunt. Sunt illo quia sit doloremque et iure voluptas est repellendus.',
    ),
    AssignmentModel(
      assignmentName: 'Requirements Document',
      dueDate: DateTime(2020, 10, 05),
      className: 'ITEC 324',
      numberNoticeDay: 3,
      assignmentDesc:
          'Sequi ducimus vel. In aperiam non odio adipisci perferendis magnam ducimus alias in. Aut blanditiis ut sequi deleniti amet ipsa. Molestias ipsa architecto consequatur aspernatur. Possimus voluptatem ipsam rerum. Fugit doloremque ut delectus voluptas ipsa ut porro eos nobis. Laboriosam rem esse neque quia. Praesentium omnis porro. Quod dolorem corrupti culpa enim. Ab eos voluptas. Nam ex deserunt sapiente aliquam ipsum. Qui est enim autem velit officiis. Voluptatem similique pariatur facere ut vel perspiciatis rerum sed.',
    ),
    AssignmentModel(
      assignmentName: 'Requirements Document',
      dueDate: DateTime(2020, 10, 05),
      className: 'ITEC 325',
      numberNoticeDay: 3,
      assignmentDesc:
          'Error explicabo aut consequuntur. In officiis neque et. Iure non ut. Eos et eos eius non incidunt. Sunt illo quia sit doloremque et iure voluptas est repellendus.',
    ),
    AssignmentModel(
      assignmentName: 'Requirements Document',
      dueDate: DateTime(2020, 10, 05),
      className: 'ITEC 325',
      numberNoticeDay: 3,
      assignmentDesc:
          'Sequi ducimus vel. In aperiam non odio adipisci perferendis magnam ducimus alias in. Aut blanditiis ut sequi deleniti amet ipsa. Molestias ipsa architecto consequatur aspernatur. Possimus voluptatem ipsam rerum. Fugit doloremque ut delectus voluptas ipsa ut porro eos nobis. Laboriosam rem esse neque quia. Praesentium omnis porro. Quod dolorem corrupti culpa enim. Ab eos voluptas. Nam ex deserunt sapiente aliquam ipsum. Qui est enim autem velit officiis. Voluptatem similique pariatur facere ut vel perspiciatis rerum sed.',
    ),
    AssignmentModel(
      assignmentName: 'Requirements Document',
      dueDate: DateTime(2020, 10, 05),
      className: 'ITEC 325',
      numberNoticeDay: 3,
      assignmentDesc:
          'Error explicabo aut consequuntur. In officiis neque et. Iure non ut. Eos et eos eius non incidunt. Sunt illo quia sit doloremque et iure voluptas est repellendus.',
    ),
    AssignmentModel(
      assignmentName: 'Requirements Document',
      dueDate: DateTime(2020, 10, 05),
      className: 'ITEC 326',
      numberNoticeDay: 3,
      assignmentDesc:
          'Sequi ducimus vel. In aperiam non odio adipisci perferendis magnam ducimus alias in. Aut blanditiis ut sequi deleniti amet ipsa. Molestias ipsa architecto consequatur aspernatur. Possimus voluptatem ipsam rerum. Fugit doloremque ut delectus voluptas ipsa ut porro eos nobis. Laboriosam rem esse neque quia. Praesentium omnis porro. Quod dolorem corrupti culpa enim. Ab eos voluptas. Nam ex deserunt sapiente aliquam ipsum. Qui est enim autem velit officiis. Voluptatem similique pariatur facere ut vel perspiciatis rerum sed.',
    ),
    AssignmentModel(
      assignmentName: 'Requirements Document',
      dueDate: DateTime(2020, 10, 05),
      className: 'ITEC 326',
      numberNoticeDay: 3,
      assignmentDesc:
          'Error explicabo aut consequuntur. In officiis neque et. Iure non ut. Eos et eos eius non incidunt. Sunt illo quia sit doloremque et iure voluptas est repellendus.',
    ),
    AssignmentModel(
      assignmentName: 'Requirements Document',
      dueDate: DateTime(2020, 10, 05),
      className: 'ITEC 324',
      numberNoticeDay: 3,
      assignmentDesc:
          'Sequi ducimus vel. In aperiam non odio adipisci perferendis magnam ducimus alias in. Aut blanditiis ut sequi deleniti amet ipsa. Molestias ipsa architecto consequatur aspernatur. Possimus voluptatem ipsam rerum. Fugit doloremque ut delectus voluptas ipsa ut porro eos nobis. Laboriosam rem esse neque quia. Praesentium omnis porro. Quod dolorem corrupti culpa enim. Ab eos voluptas. Nam ex deserunt sapiente aliquam ipsum. Qui est enim autem velit officiis. Voluptatem similique pariatur facere ut vel perspiciatis rerum sed.',
    ),
  ];
}
