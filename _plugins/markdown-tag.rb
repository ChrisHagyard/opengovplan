=begin
  Jekyll tag to include Markdown text from _includes directory preprocessing with Liquid.
  Usage:
    {% markdown <filename> %}
=end
module Jekyll
  class MarkdownTag < Liquid::Tag
    def initialize(tag_name, text, tokens)
      super
      @text = text.strip
    end

    def render(context)
      tmpl = File.read File.join Dir.pwd, "pages", @text
      tmpl=tmpl.gsub(Regexp.new("---.*---", Regexp::MULTILINE), '')
      site = context.registers[:site]
      converter = site.find_converter_instance(Jekyll::Converters::Markdown)
      tmpl = (Liquid::Template.parse tmpl).render site.site_payload
      html = converter.convert(tmpl)
    end
  end
end
Liquid::Template.register_tag('includepage', Jekyll::MarkdownTag)
