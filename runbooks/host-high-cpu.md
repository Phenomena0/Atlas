# Host high CPU

## Symptom
- **Alert:** `HostHighCpu`

## Quick checks
- Identify top CPU consumers on the host.
- On Unraid, check for Plex transcodes, parity checks, or runaway containers.

## Mitigation
- Reduce workload (pause transcodes, stop non-critical containers).
- If persistent, consider CPU pinning / resource limits.
