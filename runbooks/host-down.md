# Host down

## Symptom
- **Alert:** `HostDown`
- Prometheus cannot scrape `node-exporter` for a host.

## Impact
- Host health metrics are blind.
- If this is the Unraid host, most media workloads may be unavailable.

## Triage
1. Confirm whether it's a monitoring issue or real outage:
   - Check Prometheus targets: `Status -> Targets`.
   - Confirm ICMP/SSH to the host from the BOH plane.
2. If only Prometheus scrape is failing:
   - Verify `node-exporter` container is running on Unraid.
   - Check firewall/port 9100 reachability.

## Mitigation
- Restart `node-exporter` on Unraid.
- If the host is actually down, restore power/network and validate storage health.

## Follow-up / Prevention
- Add redundant path: second monitoring source or secondary host target.
- Add alert inhibition (already configured) to avoid alert storms.
