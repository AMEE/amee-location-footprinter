require "spec_helper"

describe FootprintMailer do

  describe 'carbon footprint mail' do

    context "was sent less than 7 days go" do

      last_week = Date.current - 6.day
      # make our user
      let(:user) { FactoryGirl.build(:user, :last_email_sent => last_week) }


      it "should not be sent" do
        # pass the user model into the Mailer, and call it 
        # WITHOUT the delayed job syntax

        ActionMailer::Base.deliveries.should be_empty
      end
    end

    context "was sent more than 7 days ago" do

      let(:user) { FactoryGirl.build(:user, :last_email_sent => Date.current - 8.day) }

      it "should be sent" do
        # this should clear the delayed jobs tables of any jobs
        FootprintMailer.footprint_email(user, user.legs).deliver
        # puts Delayed::Job.count
        # dj = Delayed::Worker.new.work_off
        # so we can then check that an email has been sent
        ActionMailer::Base.deliveries.should_not be_empty
      end

      context "has basic email elements" do

      let(:user) { FactoryGirl.build(:user, :last_email_sent => Date.current - 8.day) }
      let(:mail) { FootprintMailer.footprint_email(user, user.legs) }

        it 'renders the subject' do
          # this should clear the delayed jobs tables of any jobs

          mail.deliver        
          mail.subject.should == 'Your AMEE Personal Score for the week'
        end

      end


    end
  end

end
