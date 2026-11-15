create table if not exists public.projects (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  slug text not null unique,
  description text not null,
  thumbnail_url text not null,
  image_alt text not null,
  image_width integer not null default 1360,
  image_height integer not null default 768,
  category text not null,
  category_label text not null,
  technologies text[] not null default '{}',
  github_url text,
  demo_url text,
  is_featured boolean not null default false,
  is_published boolean not null default false,
  sort_order integer not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.skills (
  id uuid primary key default gen_random_uuid(),
  name text not null unique,
  icon text,
  sort_order integer not null default 0,
  is_visible boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.projects enable row level security;
alter table public.skills enable row level security;

revoke insert, update, delete on public.projects from anon, authenticated;
revoke insert, update, delete on public.skills from anon, authenticated;
grant select on public.projects to anon, authenticated;
grant select on public.skills to anon, authenticated;

drop policy if exists "Public can read published projects" on public.projects;
create policy "Public can read published projects"
  on public.projects for select to anon, authenticated
  using (is_published = true);

drop policy if exists "Public can read visible skills" on public.skills;
create policy "Public can read visible skills"
  on public.skills for select to anon, authenticated
  using (is_visible = true);
