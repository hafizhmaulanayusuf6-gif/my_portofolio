insert into public.projects (
  title, slug, description, thumbnail_url, image_alt, image_width, image_height,
  category, category_label, technologies, github_url, demo_url,
  is_featured, is_published, sort_order
) values
  (
    'Tracker.io', 'tracker-io',
    'An expense tracker interface based on a Dicoding beginner front-end starter project.',
    '/images/projects/tracker-io.png', 'Tracker.io income and expense dashboard screenshot', 1348, 629,
    'web-app', 'Web app', array['HTML', 'CSS', 'JavaScript'],
    'https://github.com/hafizhmaulanayusuf6-gif/tugas_akhir_FrondEnd_dicoding',
    'https://hafizhmaulanayusuf6-gif.github.io/tugas_akhir_FrondEnd_dicoding/',
    true, true, 1
  ),
  (
    'Web Portfolio', 'personal-portfolio',
    'A personal portfolio page with an introduction, technology list, and selected projects.',
    '/images/projects/portfolio-legacy.png', 'Screenshot of the previous personal portfolio website', 1348, 630,
    'portfolio', 'Portfolio', array['HTML', 'CSS', 'JavaScript'],
    'https://github.com/hafizhmaulanayusuf6-gif/tgsAkhirDicoding_profile',
    'https://hafizh-dev.netlify.app/',
    true, true, 2
  ),
  (
    'Landing Page GadgetFix', 'gadgetfix',
    'A landing page concept for a phone repair service.',
    '/images/projects/gadgetfix.png', 'GadgetFix phone repair service landing page screenshot', 1350, 630,
    'landing-page', 'Landing page', array['HTML', 'CSS'],
    'https://github.com/hafizhmaulanayusuf6-gif/LandingPage_Gadgetfix', null,
    true, true, 3
  )
on conflict (slug) do update set
  title = excluded.title,
  description = excluded.description,
  thumbnail_url = excluded.thumbnail_url,
  image_alt = excluded.image_alt,
  image_width = excluded.image_width,
  image_height = excluded.image_height,
  category = excluded.category,
  category_label = excluded.category_label,
  technologies = excluded.technologies,
  github_url = excluded.github_url,
  demo_url = excluded.demo_url,
  is_featured = excluded.is_featured,
  is_published = excluded.is_published,
  sort_order = excluded.sort_order,
  updated_at = now();

insert into public.skills (name, icon, sort_order, is_visible) values
  ('Dart', 'dart', 1, true),
  ('Flutter', 'flutter', 2, true),
  ('HTML5', 'html5', 3, true),
  ('CSS3', 'css3', 4, true),
  ('JavaScript', 'javascript', 5, true),
  ('PHP', 'php', 6, true),
  ('Laravel', 'laravel', 7, true),
  ('Node.js', 'nodedotjs', 8, true),
  ('Bootstrap', 'bootstrap', 9, true),
  ('Figma', 'figma', 10, true),
  ('MySQL', 'mysql', 11, true),
  ('Web3.js', 'web3dotjs', 12, true),
  ('Git', 'git', 13, true),
  ('GitHub', 'github', 14, true)
on conflict (name) do update set
  icon = excluded.icon,
  sort_order = excluded.sort_order,
  is_visible = excluded.is_visible,
  updated_at = now();
