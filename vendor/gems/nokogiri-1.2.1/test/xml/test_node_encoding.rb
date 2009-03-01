require File.expand_path(File.join(File.dirname(__FILE__), '..', "helper"))

module Nokogiri
  module XML
    if RUBY_VERSION =~ /^1\.9/
      class TestNodeEncoding < Nokogiri::TestCase
        def setup
          @html = Nokogiri::HTML(File.read(HTML_FILE), HTML_FILE)
        end

        def test_get_attribute
          node = @html.css('a').first
          assert_equal @html.encoding, node['href'].encoding.name
        end

        def test_encode_special_chars
          foo = @html.css('a').first.encode_special_chars('foo')
          assert_equal @html.encoding, foo.encoding.name
        end

        def test_content
          node = @html.css('a').first
          assert_equal @html.encoding, node.content.encoding.name
        end

        def test_name
          node = @html.css('a').first
          assert_equal @html.encoding, node.name.encoding.name
        end

        def test_path
          node = @html.css('a').first
          assert_equal @html.encoding, node.path.encoding.name
        end

        def test_namespace
          xml = <<-eoxml
<root>
 <car xmlns:part="http://general-motors.com/">
  <part:tire>Michelin Model XGV</part:tire>
 </car>
 <bicycle xmlns:part="http://schwinn.com/">
  <part:tire>I'm a bicycle tire!</part:tire>
 </bicycle>
</root>
          eoxml
          doc = Nokogiri::XML(xml, nil, 'UTF-8')
          assert_equal 'UTF-8', doc.encoding
          n = doc.xpath('//part:tire', { 'part' => 'http://schwinn.com/' }).first
          assert n
          assert_equal doc.encoding, n.namespace.encoding.name
        end

        def test_namespace_as_hash
          xml = <<-eoxml
<root>
 <car xmlns:part="http://general-motors.com/">
  <part:tire>Michelin Model XGV</part:tire>
 </car>
 <bicycle xmlns:part="http://schwinn.com/">
  <part:tire>I'm a bicycle tire!</part:tire>
 </bicycle>
</root>
          eoxml
          doc = Nokogiri::XML(xml, nil, 'UTF-8')
          assert_equal 'UTF-8', doc.encoding
          assert n = doc.xpath('//car').first
          n.namespaces.each do |k,v|
            assert_equal doc.encoding, v.encoding.name
            assert_equal doc.encoding, k.encoding.name
          end
        end
      end
    end
  end
end
