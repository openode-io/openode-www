# Status Probe

Our system verifies regularly that your instance is up and running by probing to a certain path (/ by default) every *N* seconds. 

## Administration Dashboard

You can change these settings using the administration dashboard in Settings > Misc.

## CLI

You can change the default value for the status probe path by using the 
following command:

    openode set-config STATUS_PROBE_PATH <path>

where *path* can be for example */status*.

You can also change the interval (in seconds) at which the probe is executed

    openode set-config STATUS_PROBE_PERIOD <interval>