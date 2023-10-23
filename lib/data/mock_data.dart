import 'package:master_clinic_flutter_app/models/appointment.dart';
import 'package:master_clinic_flutter_app/models/cabinet.dart';
import 'package:master_clinic_flutter_app/models/datetime_slot.dart';
import 'package:master_clinic_flutter_app/models/specialty.dart';
import 'package:master_clinic_flutter_app/models/user.dart';

final mockCabinets = [
  Cabinet(id: '1', name: 'Cabinet 1', floor: 1),
  Cabinet(id: '2', name: 'Cabinet 2', floor: 2),
  Cabinet(id: '3', name: 'Cabinet 3', floor: 3),
];

final mockSpecialties = [
  Specialty(id: '1', name: 'Specialty 1', defaultBeforeVisit: 'test before visit 1'),
  Specialty(id: '2', name: 'Specialty 2', defaultBeforeVisit: 'test before visit 2'),
  Specialty(id: '3', name: 'Specialty 3', defaultBeforeVisit: 'test before visit 3'),
];

final mockPatients = [
  User(
    id: '1',
    role: UserRole.patient,
    email: 'patient1@masterclinic.com',
    firstName: 'Name 1',
    lastName: 'Last Name 1',
    telephone: '48 000 111 222',
    active: true,
  ),
  User(
    id: '2',
    role: UserRole.patient,
    email: 'patient2@masterclinic.com',
    firstName: 'Name 2',
    lastName: 'Last Name 2',
    telephone: '48 000 111 222',
    active: true,
  ),
  User(
    id: '3',
    role: UserRole.patient,
    email: 'patient3@masterclinic.com',
    firstName: 'Name 3',
    lastName: 'Last Name 3',
    telephone: '48 000 111 222',
    active: true,
  ),
];

final mockDoctors = [
  User(
    id: '4',
    role: UserRole.doctor,
    email: 'doctor1@masterclinic.com',
    firstName: 'Name 1',
    lastName: 'Last Name 1',
    telephone: '48 000 111 222',
    active: true,
    specialtyId: mockSpecialties[0].id,
    cabinetId: mockCabinets[0].id,
  ),
  User(
    id: '5',
    role: UserRole.doctor,
    email: 'doctor2@masterclinic.com',
    firstName: 'Name 2',
    lastName: 'Last Name 2',
    telephone: '48 000 111 222',
    active: true,
    specialtyId: mockSpecialties[1].id,
    cabinetId: mockCabinets[1].id,
  ),
  User(
    id: '6',
    role: UserRole.doctor,
    email: 'doctor3@masterclinic.com',
    firstName: 'Name 3',
    lastName: 'Last Name 3',
    telephone: '48 000 111 222',
    active: true,
    specialtyId: mockSpecialties[2].id,
    cabinetId: mockCabinets[2].id,
  ),
];

final mockAppointments = [
  Appointment(
    id: '1',
    dateTime: '2023-04-25 10:00:00.000000',
    description: 'Description 1',
    beforeVisit: 'Before Visit 1',
    specialty: mockSpecialties[0],
    patient: mockPatients[0],
    doctor: mockDoctors[0],
    cabinet: mockCabinets[0],
  ),
  Appointment(
    id: '2',
    dateTime: '2023-04-26 10:00:00.000000',
    description: 'Description 2',
    beforeVisit: 'Before Visit 3',
    specialty: mockSpecialties[1],
    patient: mockPatients[1],
    doctor: mockDoctors[1],
    cabinet: mockCabinets[1],
  ),
  Appointment(
    id: '3',
    dateTime: '2023-04-27 10:00:00.000000',
    description: 'Description 3',
    beforeVisit: 'Before Visit 3',
    specialty: mockSpecialties[2],
    patient: mockPatients[2],
    doctor: mockDoctors[2],
    cabinet: mockCabinets[2],
  ),
];

final mockDatetimeSlots = [
  DatetimeSlot(
    id: '1',
    doctor: mockDoctors[0],
    slotDatetime: '2023-05-25 10:00:00.000000',
    isFree: false,
  ),
  DatetimeSlot(
    id: '2',
    doctor: mockDoctors[1],
    slotDatetime: '2023-05-26 10:00:00.000000',
    isFree: true,
  ),
  DatetimeSlot(
    id: '3',
    doctor: mockDoctors[2],
    slotDatetime: '2023-05-27 10:00:00.000000',
    isFree: true,
  ),
];
