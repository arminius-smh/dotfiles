{ ... }:
{
  time = {
    timeZone = "Europe/Berlin";
    # windows dual boot compatability
    # better: fix windows instead
    # 'reg add HKLM\SYSTEM\CurrentControlSet\Control\TimeZoneInformation /v RealTimeIsUniversal /t REG_DWORD /d 1'
    # hardwareClockInLocalTime = true;
  };
}
