-- ============================================================
-- 혼잡스 대기자(waitlist) 테이블 설정
-- Supabase 대시보드 → SQL Editor 에 붙여넣고 [Run] 하세요.
-- ============================================================

-- 1) 테이블 생성
create table if not exists public.waitlist (
  id          bigint generated always as identity primary key,
  email       text not null unique,
  created_at  timestamptz not null default now()
);

-- 2) RLS(행 수준 보안) 활성화
--    켜지 않으면 anon(공개) 키로 접근이 막혀 저장이 안 됩니다.
alter table public.waitlist enable row level security;

-- 3) 정책: 누구나 "등록(INSERT)"만 가능하도록 허용
--    (SELECT 권한은 주지 않아 다른 사람의 이메일은 읽을 수 없습니다)
create policy "anyone can join waitlist"
  on public.waitlist
  for insert
  to anon, authenticated
  with check (true);
