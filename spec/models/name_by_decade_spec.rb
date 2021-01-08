require_relative '../../lib/census/models/name_by_decade'

describe NameByDecade do
  describe '.fetch_names' do
    context 'when all names are found' do
      it 'returns a NameByDecadeResult' do
        json_response = File.read(File.join(File.dirname(__FILE__), '../support/apis/get_names_by_decades.json'))
        faraday_response = double('names_by_decades', status: 200, body: json_response)
        allow(Faraday).to receive(:get).with("#{Census.config.names_url}/#{CGI.escape('felipe|gabriel')}")
                                       .and_return(faraday_response)
        input_string = 'felipe, gabriel'

        names_result = NameByDecade.fetch_names(input_string)

        expect(names_result).to be_instance_of(NameByDecadeResult)
        expect(names_result.names).to be_instance_of(Array)
        expect(names_result.names.size).to eq(2)
        expect(names_result.names.first).to be_instance_of(NameByDecade)
        expect(names_result.names_not_found).to be_instance_of(Array)
        expect(names_result.names_not_found).to be_empty
      end
    end

    context 'when some names are not found' do
      it 'returns a hash containing an array of NameByDecade with names found and an array with names not found' do
        json_response = File.read(File.join(File.dirname(__FILE__), '../support/apis/get_names_by_decades.json'))
        faraday_response = double('names_by_decades', status: 200, body: json_response)
        allow(Faraday).to receive(:get).with("#{Census.config.names_url}/"\
                                             "#{CGI.escape('felipe|gabriel|invalid|notaname')}")
                                       .and_return(faraday_response)
        input_string = 'felipe, gabriel, invalid, notaname'

        names_result = NameByDecade.fetch_names(input_string)

        expect(names_result.names.length).to eq(2)
        expect(names_result.names.first).to be_instance_of(NameByDecade)
        expect(names_result.names_not_found).to include('invalid')
        expect(names_result.names_not_found).to include('notaname')
      end
    end

    context 'when there is only one name' do
      it 'returns a hash containing an array of with one NameByDecade element, and an empty array' do
        json_response = File.read(File.join(File.dirname(__FILE__), '../support/apis/get_name_by_decades.json'))
        faraday_response = double('names_by_decades', status: 200, body: json_response)
        allow(Faraday).to receive(:get).with("#{Census.config.names_url}/#{CGI.escape('felipe')}")
                                       .and_return(faraday_response)
        input_string = 'felipe'

        names_result = NameByDecade.fetch_names(input_string)

        expect(names_result.names.length).to eq(1)
        expect(names_result.names.first.name).to eq('felipe')
        expect(names_result.names_not_found).to be_empty
      end
    end
  end
end
