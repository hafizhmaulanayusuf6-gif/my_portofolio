import { createClient } from '@supabase/supabase-js';
import { portfolioData } from '~/data/portfolio.js';

export function usePortfolioData() {
  const config = useRuntimeConfig();

  return useAsyncData('portfolio-content', async () => {
    const { supabaseUrl, supabasePublishableKey } = config.public;
    if (!supabaseUrl || !supabasePublishableKey) return portfolioData;

    const supabase = createClient(supabaseUrl, supabasePublishableKey);
    const [projectResult, skillResult] = await Promise.all([
      supabase.from('projects').select('*').eq('is_published', true).order('sort_order'),
      supabase.from('skills').select('*').eq('is_visible', true).order('sort_order'),
    ]);

    if (projectResult.error) throw projectResult.error;
    if (skillResult.error) throw skillResult.error;

    return {
      ...portfolioData,
      projects: projectResult.data.map((project) => ({
        id: project.slug || project.id,
        title: project.title,
        description: project.description,
        category: project.category,
        categoryLabel: project.category_label || project.category,
        thumbnail: project.thumbnail_url,
        imageAlt: project.image_alt || `${project.title} project screenshot`,
        imageWidth: project.image_width || 1360,
        imageHeight: project.image_height || 768,
        technologies: project.technologies || [],
        githubUrl: project.github_url || '',
        demoUrl: project.demo_url || '',
        featured: project.is_featured,
        published: project.is_published,
      })),
      skills: skillResult.data.map((skill) => ({ name: skill.name, icon: skill.icon || '' })),
    };
  }, {
    default: () => portfolioData,
  });
}
