require "spec_helper"

describe FootprintMailer do

    describe 'carbon footprint mail' do
      # pass the user model into the Mailer

      # make our user
      let(:user) { FactoryGirl.build(:user) }
      let(:mail) { FootprintMailer.footprint_email(user) }

      # #ensure that the subject is correct
      it 'renders the subject' do
        # pending
        mail.subject.should == 'Check out your Checkins'
      end

      # #ensure that the @name variable appears in the email body
      # it 'assigns @name' do
      #   mail.body.encoded.should match(user.name)
      # end
      #
      # #ensure that the @confirmation_url variable appears in the email body
      # it 'assigns @confirmation_url' do
      #   mail.body.encoded.should match("http://aplication_url/#{user.id}/confirmation")
      # end

  end

end
