-- Copia de seguridad 2025-12-10
-- Crea tablas backup con estructura y datos actuales

-- inscripcions
CREATE TABLE IF NOT EXISTS public.inscripcions_backup_20251210 (LIKE public.inscripcions INCLUDING ALL);
TRUNCATE TABLE public.inscripcions_backup_20251210;
INSERT INTO public.inscripcions_backup_20251210 SELECT * FROM public.inscripcions;

-- payments
CREATE TABLE IF NOT EXISTS public.payments_backup_20251210 (LIKE public.payments INCLUDING ALL);
TRUNCATE TABLE public.payments_backup_20251210;
INSERT INTO public.payments_backup_20251210 SELECT * FROM public.payments;

-- payment_history
CREATE TABLE IF NOT EXISTS public.payment_history_backup_20251210 (LIKE public.payment_history INCLUDING ALL);
TRUNCATE TABLE public.payment_history_backup_20251210;
INSERT INTO public.payment_history_backup_20251210 SELECT * FROM public.payment_history;

-- monthly_payment_generation
CREATE TABLE IF NOT EXISTS public.monthly_payment_generation_backup_20251210 (LIKE public.monthly_payment_generation INCLUDING ALL);
TRUNCATE TABLE public.monthly_payment_generation_backup_20251210;
INSERT INTO public.monthly_payment_generation_backup_20251210 SELECT * FROM public.monthly_payment_generation;


