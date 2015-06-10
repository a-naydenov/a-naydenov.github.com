# hacked from http://www.dotnetguy.co.uk/post/2012/06/25/octopress-category-list-plugin/
# source https://kaworu.ch/blog/2013/09/23/categories-page-with-octopress/
module Jekyll
  class CategoryListTag < Liquid::Tag
    def initialize(tag_name, markup, tokens)
      @tagcloud = (tag_name == 'category_tag_cloud')
    end
    def render(context)
      html = ""
      categories = context.registers[:site].categories.keys
      categories.sort.each do |category|
        posts_in_category = context.registers[:site].categories[category].size
        len = 0.6 + posts_in_category * 0.1
        category_dir = context.registers[:site].config['category_dir']
        category_url = File.join(category_dir, category.gsub(/_|\P{Word}/, '-').gsub(/-{2,}/, '-').downcase)
        if @tagcloud
          html << "<li style='list-style-type:none;display:inline;' class='category'><a style='font-size:#{len}em' href='/#{category_url}/'>#{category}</a></li> "
        else
          posts_str = (if posts_in_category < SUB_ONE_THOUSAND.size then SUB_ONE_THOUSAND[posts_in_category] else '15+' end)
          # posts_str += (if posts_in_category == 1 then 'пост' else '' end)
          html << "<article><h1><a href='/#{category_url}/'>#{category}</a></h1><span class='post-count' data-count='#{posts_in_category}'>#{posts_str}</span></article>"
        end
      end
      html
    end
    # stolen from the humanize gem :)
    # SUB_ONE_THOUSAND = ['zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine', 'ten', 'eleven', 'twelve', 'thirteen', 'fourteen', 'fifteen', 'sixteen', 'seventeen', 'eighteen', 'nineteen', 'twenty', 'twenty-one', 'twenty-two', 'twenty-three', 'twenty-four', 'twenty-five', 'twenty-six', 'twenty-seven', 'twenty-eight', 'twenty-nine', 'thirty', 'thirty-one', 'thirty-two', 'thirty-three', 'thirty-four', 'thirty-five', 'thirty-six', 'thirty-seven', 'thirty-eight', 'thirty-nine', 'forty', 'forty-one', 'forty-two', 'forty-three', 'forty-four', 'forty-five', 'forty-six', 'forty-seven', 'forty-eight', 'forty-nine', 'fifty', 'fifty-one', 'fifty-two', 'fifty-three', 'fifty-four', 'fifty-five', 'fifty-six', 'fifty-seven', 'fifty-eight', 'fifty-nine', 'sixty', 'sixty-one', 'sixty-two', 'sixty-three', 'sixty-four', 'sixty-five', 'sixty-six', 'sixty-seven', 'sixty-eight', 'sixty-nine', 'seventy', 'seventy-one', 'seventy-two', 'seventy-three', 'seventy-four', 'seventy-five', 'seventy-six', 'seventy-seven', 'seventy-eight', 'seventy-nine', 'eighty', 'eighty-one', 'eighty-two', 'eighty-three', 'eighty-four', 'eighty-five', 'eighty-six', 'eighty-seven', 'eighty-eight', 'eighty-nine', 'ninety', 'ninety-one', 'ninety-two', 'ninety-three', 'ninety-four', 'ninety-five', 'ninety-six', 'ninety-seven', 'ninety-eight', 'ninety-nine', 'one hundred']
    SUB_ONE_THOUSAND = ['ни одного', 'один пост', 'два поста', 'три поста', 'четыре поста', 'пять постов', 'шесть постов', 'семь постиков', 'восемь постов', 'девять постов', 'десять постов', 'одиннадцать постов', 'двенадцать постов', 'тринадцатьпостов', 'четырнадцать постов', 'пятнадцать постов', '15']

  end
end

Liquid::Template.register_tag('category_list', Jekyll::CategoryListTag)
Liquid::Template.register_tag('category_tag_cloud', Jekyll::CategoryListTag)
