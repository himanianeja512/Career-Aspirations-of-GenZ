use genzdataset;
show tables;
select * from personalized_info;
#question 1 :How many males have corresponded to the survey from india
select count(Gender) as male_count from personalized_info 
where Gender like "Male%" and CurrentCountry="India";
#question 2 :How many females have corresponded to the survey from india
select count(Gender) as male_count from personalized_info 
where Gender like "Female%" and CurrentCountry="India";
#question3 : How many of the Gen Z are influenced by their parents in regards to their career choices from India. 
Select count(CareerInfluenceFactor) from learning_aspirations
inner join personalized_info
on learning_aspirations.ResponseID=personalized_info.ResponseID
where learning_aspirations.CareerInfluenceFactor="My Parents" and personalized_info.CurrentCountry="India";
#question4 : How many of the Female Gen Z are influenced by their parents in regards to their career choices from India. 
Select count(CareerInfluenceFactor) from learning_aspirations
inner join personalized_info
on learning_aspirations.ResponseID=personalized_info.ResponseID
where learning_aspirations.CareerInfluenceFactor="My Parents" and personalized_info.CurrentCountry="India" and personalized_info.Gender like "Female%";

#question5 : How many of the male Gen Z are influenced by their parents in regards to their career choices from India. 
Select count(CareerInfluenceFactor) from learning_aspirations
inner join personalized_info
on learning_aspirations.ResponseID=personalized_info.ResponseID
where learning_aspirations.CareerInfluenceFactor="My Parents" and personalized_info.CurrentCountry="India" and personalized_info.Gender like "male%";

#question 6 How many of the Male and Female (indiviually display in 2 different columns,but as part of the same query)GenZ are influenced by their parents in regards to their carrer choiced from India.
Select personalized_info.Gender,count(CareerInfluenceFactor) from learning_aspirations
inner join personalized_info
on learning_aspirations.ResponseID=personalized_info.ResponseID
where learning_aspirations.CareerInfluenceFactor="My Parents" and personalized_info.CurrentCountry="India" 
group by personalized_info.Gender;

#question7 How many GenZ are influenced by Social Media and Influencers together from India.
Select count(CareerInfluenceFactor) from learning_aspirations
inner join personalized_info
on learning_aspirations.ResponseID=personalized_info.ResponseID
where (learning_aspirations.CareerInfluenceFactor like "Social Media%" or learning_aspirations.CareerInfluenceFactor like "Influencers%" )and personalized_info.CurrentCountry="India";
#question8 How many GenZ are influenced by Social Media and Influencers together ,display for Male and Female Seperately from India
Select personalized_info.Gender,count(CareerInfluenceFactor) from learning_aspirations
inner join personalized_info
on learning_aspirations.ResponseID=personalized_info.ResponseID
where (learning_aspirations.CareerInfluenceFactor like "Social Media%" or learning_aspirations.CareerInfluenceFactor like "Influencers%" )and personalized_info.CurrentCountry="India"
group by personalized_info.Gender;
#question9 How many GenZ are influenced by Social Media for their Career Aspiration are looking to go abroad
Select count(CareerInfluenceFactor) from learning_aspirations
where learning_aspirations.CareerInfluenceFactor like "Social Media%" and learning_aspirations.HigherEducationAbroad like "Yes%";
#question 10 How many GenZ are influenced by "people in their circle" for career aspiration are looking to go abroad
Select count(CareerInfluenceFactor) from learning_aspirations
where learning_aspirations.CareerInfluenceFactor like "People from my circle%" and learning_aspirations.HigherEducationAbroad like "Yes%";



