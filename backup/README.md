## Backups creados

- 2025-12-10: tablas copiadas en Supabase con sufijo `_backup_20251210`.
  - `inscripcions_backup_20251210`
  - `payments_backup_20251210`
  - `payment_history_backup_20251210`
  - `monthly_payment_generation_backup_20251210`

## Cómo restaurar (manual)

1. Conecta a la base (psql o Supabase SQL editor).
2. Ejecuta el SQL de `2025-12-10-backup.sql` ajustando los nombres si deseas restaurar sobre tablas actuales.

## Nota

Los backups en la base ya incluyen estructura (`LIKE ... INCLUDING ALL`) y datos copiados a la fecha indicada.


