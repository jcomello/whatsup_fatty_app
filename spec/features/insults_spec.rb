require 'rails_helper'

describe "Insults" do
  context "List insults" do
    context "when there is insult" do
      let!(:insult) { FactoryGirl.create(:insult) }
      let!(:other_insult) { FactoryGirl.create(:insult, phrase: 'Ahan, te peguei comendo porcaria', eating_what: 'McDonalds') }

      it "shows insults" do
        visit insults_path

        expect(page).to have_content insult.phrase
        expect(page).to have_content insult.eating_what

        expect(page).to have_content other_insult.phrase
        expect(page).to have_content other_insult.eating_what
      end
    end

    context "when there isn't insults" do
      it "shows message of not found insults" do
        visit insults_path

        expect(page).to have_content I18n.t('insults.index.not_found')
      end
    end
  end

  context "Create insult" do
    context "when fields are correct" do
      it "creates a new insult" do
        visit new_insult_path

        fill_in I18n.t('activerecord.attributes.insult.eating_what'), with: "Cachorro quente"
        fill_in I18n.t('activerecord.attributes.insult.phrase'),      with: "Maladrão, para de comer besteira, rapaz!"

        click_button I18n.t('buttons.save')

        expect(page.current_path).to eq insults_path
        expect(page).to have_content I18n.t('insults.notice.create_successful')
      end
    end

    context "when fields are not correct" do
      context "when eating_what field is blank" do
        it "shows an error message" do
          visit new_insult_path

          fill_in I18n.t('activerecord.attributes.insult.phrase'),      with: "Maladrão, para de comer besteira, rapaz!"

          click_button I18n.t('buttons.save')

          expect(page).to have_no_content I18n.t('insults.notice.create_successful')
        end
      end

      context "when phrase field is blank" do
        it "shows an error message" do
          visit new_insult_path

          fill_in I18n.t('activerecord.attributes.insult.eating_what'), with: "Cachorro quente"

          click_button I18n.t('buttons.save')

          expect(page).to have_no_content I18n.t('insults.notice.create_successful')
        end
      end

      context "when phrase field is to big" do
        it "shows an error message" do
          visit new_insult_path

          fill_in I18n.t('activerecord.attributes.insult.eating_what'), with: "Cachorro quente"
          fill_in I18n.t('activerecord.attributes.insult.phrase'),      with: "Maladrão, para de comer besteira, rapaz! HAHAHAHAHAHAHAHAHAHAHAHAHHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHHAhhAHHAAHAHAHAHAHAHAHAHAHHAHAHAH"

          click_button I18n.t('buttons.save')

          expect(page).to have_content I18n.t('activerecord.errors.models.insult.attributes.phrase.too_long')
        end
      end
    end
  end

  context "Update insult" do
    let!(:insult) { FactoryGirl.create(:insult) }

    context "when fields are correct" do
      it "updates a new insult" do
        visit edit_insult_path(insult)

        fill_in I18n.t('activerecord.attributes.insult.eating_what'), with: "Cachorro quente"
        fill_in I18n.t('activerecord.attributes.insult.phrase'),      with: "Maladrão, para de comer besteira, rapaz!"

        click_button I18n.t('buttons.save')

        expect(page.current_path).to eq insults_path
        expect(page).to have_content I18n.t('insults.notice.update_successful')

        expect(page).to have_content "Cachorro quente"
        expect(page).to have_content "Maladrão, para de comer besteira, rapaz!"
      end
    end

    context "when fields are not correct" do
      context "when eating_what field is blank" do
        it "shows an error message" do
          visit edit_insult_path(insult)

          fill_in I18n.t('activerecord.attributes.insult.phrase'),      with: "Maladrão, para de comer besteira, rapaz!"
          fill_in I18n.t('activerecord.attributes.insult.eating_what'), with: " "

          click_button I18n.t('buttons.save')

          expect(page).to have_content I18n.t('activerecord.errors.models.insult.attributes.eating_what.blank')
        end
      end

      context "when phrase field is blank" do
        it "shows an error message" do
          visit edit_insult_path(insult)

          fill_in I18n.t('activerecord.attributes.insult.eating_what'), with: "Cachorro quente"
          fill_in I18n.t('activerecord.attributes.insult.phrase'), with: " "

          click_button I18n.t('buttons.save')
          expect(page).to have_content I18n.t('activerecord.errors.models.insult.attributes.phrase.blank')
        end
      end

      context "when phrase field is to big" do
        it "shows an error message" do
          visit edit_insult_path(insult)

          fill_in I18n.t('activerecord.attributes.insult.eating_what'), with: "Cachorro quente"
          fill_in I18n.t('activerecord.attributes.insult.phrase'),      with: "Maladrão, para de comer besteira, rapaz! HAHAHAHAHAHAHAHAHAHAHAHAHHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHHAhhAHHAAHAHAHAHAHAHAHAHAHHAHAHAH"

          click_button I18n.t('buttons.save')

          expect(page).to have_content I18n.t('activerecord.errors.models.insult.attributes.phrase.too_long')
        end
      end
    end
  end
end
