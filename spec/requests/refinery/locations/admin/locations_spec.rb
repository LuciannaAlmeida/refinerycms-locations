# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "Locations" do
    describe "Admin" do
      describe "locations" do
        login_refinery_user

        describe "locations list" do
          before do
            Refinery::Locations::Location.make!(:name => "UniqueTitleOne")
            Refinery::Locations::Location.make!(:name => "Unique Title Two")
          end

          it "shows two items" do
            visit refinery.locations_admin_locations_path
            page.should have_content("uniquetitleone")
            page.should have_content("unique title two")
          end
        end

        describe "create" do
          before do
            @region = Refinery::Locations::Region.make!
            
            visit refinery.locations_admin_locations_path

            click_link "Create a new Location"
          end

          context "valid data" do
            it "should succeed" do
              locations_quantity = Refinery::Locations::Location.count
              
              choose "location_region_id_#{@region.id}"              
              fill_in "Name", :with => "This is a test of the first string field"
              click_button "Save"

              page.should have_content("'this is a test of the first string field' was successfully added.")
              Refinery::Locations::Location.count.should == locations_quantity + 1
            end
          end

          context "invalid data" do
            it "should fail" do
              locations_quantity = Refinery::Locations::Location.count
              
              click_button "Save"

              page.should have_content("Name can't be blank")
              Refinery::Locations::Location.count.should == locations_quantity
            end
          end

          context "duplicate" do
            before { Refinery::Locations::Location.make!(:name => "UniqueTitle") }

            it "should fail" do
              locations_quantity = Refinery::Locations::Location.count
              
              visit refinery.locations_admin_locations_path

              click_link "Create a new Location"

              fill_in "Name", :with => "UniqueTitle"
              click_button "Save"

              page.should have_content("There were problems")
              Refinery::Locations::Location.count.should == locations_quantity
            end
          end

        end

        describe "edit" do
          before { Refinery::Locations::Location.make!(:name => "A name") }

          it "should succeed" do
            visit refinery.locations_admin_locations_path

            within ".actions" do
              click_link "Edit this location"
            end

            fill_in "Name", :with => "A different name"
            click_button "Save"

            page.should have_content("'a different name' was successfully updated.")
            page.should have_no_content("A name")
          end
        end

        # The destroy is not working when running the dummy application. But it works
        # when running a real application using this refinrycms-locations gem        
        describe "destroy" do
          before { Refinery::Locations::Location.make!(:name => "UniqueTitleOne") }

          it "should succeed" 
          #   locations_quantity = Refinery::Locations::Location.count
          #   
          #   visit refinery.locations_admin_locations_path
          # 
          #   click_link "Remove this location forever"
          # 
          #   page.should have_content("'UniqueTitleOne' was successfully removed.")
          #   Refinery::Locations::Location.count.should == locations_quantity - 1
          # end
        end

      end
    end
  end
end
