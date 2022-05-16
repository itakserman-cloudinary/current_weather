require "rails_helper"

RSpec.describe Location, :type => :model do
    let(:valid_location) { Location.create(:city => "Raanana", :coutry_code => "IL", :lat => 0.321861481e2, :lon => 0.348675905e2) }
    let(:invalid_location) { Location.create(:city => "Raanana", :coutry_code => "DD", :lat => 0.321861481e2, :lon => 0.348675905e2) }
    
    before do
        Location.any_instance.stub(:get_coordinates_from_external_system) do |location|
            location.lat, location.lon = 0.11111, 0.11111
        end
        valid_location
        invalid_location
    end

    it "country_code_exists blocks no existing coutnry code" do
        expect(valid_location.id.nil?).to eql false
    end

    it "country_code_exists approves existing coutnry code" do
        expect(invalid_location.id.nil?).to eql true
    end

    it "get_coordinates_from_external_system middlewear was triggered" do
        expect(valid_location.lat).to eql 0.11111
        expect(valid_location.lon).to eql 0.11111
    end

    it "fetch existing location retrieves it" do
        location = Location.fetch({:city => "Raanana", :coutry_code => "IL"})
        expect(location.id).to eql valid_location.id
    end

    it "fetch non existing location creates it" do
        location = Location.fetch({:city => "Netanya", :coutry_code => "IL"})
        expect(location.id).not_to eql valid_location.id
    end
end