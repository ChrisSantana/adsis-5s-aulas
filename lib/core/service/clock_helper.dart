abstract interface class IClockHelper {
  DateTime? get currentDateTime;
}

final class ClockHelper implements IClockHelper {
  @override
  DateTime get currentDateTime => DateTime.now();
}
