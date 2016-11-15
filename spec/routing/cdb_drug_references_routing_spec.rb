require "rails_helper"

RSpec.describe CdbDrugReferencesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/cdb_drug_references").to route_to("cdb_drug_references#index")
    end

    it "routes to #new" do
      expect(:get => "/cdb_drug_references/new").to route_to("cdb_drug_references#new")
    end

    it "routes to #show" do
      expect(:get => "/cdb_drug_references/1").to route_to("cdb_drug_references#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/cdb_drug_references/1/edit").to route_to("cdb_drug_references#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/cdb_drug_references").to route_to("cdb_drug_references#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/cdb_drug_references/1").to route_to("cdb_drug_references#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/cdb_drug_references/1").to route_to("cdb_drug_references#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/cdb_drug_references/1").to route_to("cdb_drug_references#destroy", :id => "1")
    end

  end
end
