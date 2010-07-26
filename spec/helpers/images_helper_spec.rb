require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the CoucousHelper. For example:
#
# describe CoucousHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe ImagesHelper do
  describe "boolean_to_image" do
     it "convert a boolean value to an image with I18n text" do
       helper.boolean_to_image(true).should have_selector("img",
                                                          :title => I18n.t('yes'),
                                                          :alt => I18n.t('yes'),
                                                          :src => "/images/actions/yes.png?315529200")

       helper.boolean_to_image(false).should have_selector("img",
                                                          :title => I18n.t('no'),
                                                          :alt => I18n.t('no'),
                                                          :src => "/images/actions/no.png?315529200")
     end
   end
end
