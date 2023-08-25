import 'package:master_clinic_flutter_app/models/appointment.dart';
import 'package:master_clinic_flutter_app/models/cabinet.dart';
import 'package:master_clinic_flutter_app/models/datetime_slot.dart';
import 'package:master_clinic_flutter_app/models/doctor.dart';
import 'package:master_clinic_flutter_app/models/patient.dart';
import 'package:master_clinic_flutter_app/models/specialty.dart';

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
  Patient(
    id: '1',
    email: 'patient1@masterclinic.com',
    firstName: 'Name 1',
    lastName: 'Last Name 1',
    fullName: 'Name 1 Last Name 1',
    telephone: '48 000 111 222',
    active: true,
  ),
  Patient(
    id: '2',
    email: 'patient2@masterclinic.com',
    firstName: 'Name 2',
    lastName: 'Last Name 2',
    fullName: 'Name 2 Last Name 2',
    telephone: '48 000 111 222',
    active: true,
  ),
  Patient(
    id: '3',
    email: 'patient3@masterclinic.com',
    firstName: 'Name 3',
    lastName: 'Last Name 3',
    fullName: 'Name 3 Last Name 3',
    telephone: '48 000 111 222',
    active: true,
  ),
];

final mockDoctors = [
  Doctor(
    id: '1',
    email: 'doctor1@masterclinic.com',
    firstName: 'Name 1',
    lastName: 'Last Name 1',
    fullName: 'Name 1 Last Name 1',
    telephone: '48 000 111 222',
    active: true,
    specialty: mockSpecialties[0],
    cabinet: mockCabinets[0],
  ),
  Doctor(
    id: '2',
    email: 'doctor2@masterclinic.com',
    firstName: 'Name 2',
    lastName: 'Last Name 2',
    fullName: 'Name 2 Last Name 2',
    telephone: '48 000 111 222',
    active: true,
    specialty: mockSpecialties[1],
    cabinet: mockCabinets[1],
  ),
  Doctor(
    id: '3',
    email: 'doctor3@masterclinic.com',
    firstName: 'Name 3',
    lastName: 'Last Name 3',
    fullName: 'Name 3 Last Name 3',
    telephone: '48 000 111 222',
    active: true,
    specialty: mockSpecialties[2],
    cabinet: mockCabinets[2],
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
