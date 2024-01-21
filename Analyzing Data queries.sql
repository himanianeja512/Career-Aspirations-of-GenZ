use genzdataset;
#ques1 What percentage of male and female genZ wants to go to office everyday ?(use join function and don't take merged dataset)
Select ((sum(case when gender like "Male%" and PreferredWorkingEnvironment like "Every Day office%" then 1 else 0 end)/count(*))*100) as male_percentage,((sum(case when gender like "Female%" and PreferredWorkingEnvironment like "Every Day office%" then 1 else 0 end)/count(*))*100) as female_percentage from  learning_aspirations
inner join personalized_info
on learning_aspirations.ResponseID=personalized_info.ResponseID;

#ques2 What percentage of GenZ's who have chosen their career in Business Operations are most likely to be  influenced by their parents
Select (avg(case when ClosestAspirationalCareer like "Business Operations%"  and learning_aspirations.CareerInfluenceFactor="My Parents" then 1 else 0 end )*100) as business_carrerchoice from learning_aspirations;

#ques3 What percentage of GenZ prefer opting for higher studies,give a gender wise approach?
Select((sum(case when gender like "Male%" and learning_aspirations.HigherEducationAbroad like "Yes%" then 1 else 0 end)/count(*))*100) as male_percentage,((sum(case when gender like "Female%" and learning_aspirations.HigherEducationAbroad like "Yes%" then 1 else 0 end)/count(*))*100) as female_percentage, ((sum(case when gender like "Transgender%" and learning_aspirations.HigherEducationAbroad like "Yes%" then 1 else 0 end)/count(*))*100) as Transgender_percentage  from  learning_aspirations
inner join personalized_info
on learning_aspirations.ResponseID=personalized_info.ResponseID;
#ques4 what percentage of Gen are willing and not willing to work for a company whose mission is misaligned with their public actions or even their products?(give gender split)
Select gender, ((sum(case when MisalignedMissionLikelihood like "Will NOT work%" then 1 else 0 end)/count(*))*100) as workwilling_percentage,((sum(case when MisalignedMissionLikelihood like "Will work%" then 1 else 0 end)/count(*))*100) as worknotwilling_percentage from  mission_aspirations
inner join personalized_info
on mission_aspirations.ResponseID=personalized_info.ResponseID
where gender is not null
group by personalized_info.Gender;
#ques5 what is the most suitable working environment according to female genz's?
select count(PreferredWorkingEnvironment) as max_preferred ,PreferredWorkingEnvironment from learning_aspirations
inner join personalized_info
on learning_aspirations.ResponseID=personalized_info.ResponseID
where gender like "Female%"
group by PreferredWorkingEnvironment
order by max_preferred desc limit 1;
#ques6 What is the percentage of Males who expected a salary 5 years>50k and also work under employers who appreciates learning but doesn't enables an learning environment?
Select ((sum(case when gender like "Male%" and ExpectedSalary5Years >50 and PreferredEmployer like "Employers who appreciates learning but doesn't enables an learning environment%" then 1 else 0 end)/count(*))*100) as male_percentage from mission_aspirations
inner join personalized_info on mission_aspirations.ResponseID=personalized_info.ResponseID
inner join manager_aspirations on mission_aspirations.ResponseID=manager_aspirations.ResponseID;
#ques7 find out the correlation between gender about their preferredworkSetup?

#ques8 Calculate the total number of Female who aspire to work in their Closest Aspirational Career and have a No Social impact likelihood of "1 to 5"
select count(personalized_info.gender like "Female%") from learning_Aspirations 
inner join mission_Aspirations on mission_aspirations.responseid=learning_aspirations.responseid
inner join personalized_info on learning_aspirations.ResponseID=personalized_info.ResponseID
where learning_aspirations.ClosestAspirationalCareer like "%Work%" and mission_aspirations.NoSocialImpactLikelihood between 1 and 5;
#ques9 Retrieve the Male who are interested in Higher education Abroad and have a Carrer Influence Factor of "My Parents"
select count(personalized_info.gender like "Male%") from learning_Aspirations 
inner join personalized_info on personalized_info.responseid=learning_aspirations.responseid
where learning_aspirations.HigherEducationAbroad like "Yes%" and learning_aspirations.CareerInfluenceFactor="My Parents";

#ques10 Determine the Percentage of Gender who have a No Social Impact likelihood of "8 to 10" among those who are interested in Higher Education Abroad
select ((sum(case when (mission_aspirations.NoSocialImpactLikelihood between 8 and 10 and learning_aspirations.HigherEducationAbroad like "Yes%") then 1 else 0 end)/count(*))*100) from learning_aspirations
inner join mission_Aspirations on mission_aspirations.responseid=learning_aspirations.responseid;
#ques11 Give a detailed split of genZ's preferences to work with Teams,data should include Male,Female and Overall in counts and overall in %?
select sum(case when gender like "Male%" and PreferredWorksetup like "%team%" then 1 else 0 end)as male_count,sum(case when gender like "Female%" and PreferredWorksetup like "%team%" then 1 else 0 end)as female_count,((sum(case when gender like "Male%" and PreferredWorksetup like "%team%" then 1 else 0 end)/count(*))*100) as male_percentage ,((sum(case when gender like "female%" and PreferredWorkSetup like "%team%" then 1 else 0 end)/count(*))*100) as female_percentage from learning_Aspirations 
inner join personalized_info on learning_aspirations.ResponseID=personalized_info.ResponseID
inner join manager_Aspirations on manager_aspirations.responseid=learning_aspirations.responseid;
#ques12 Give a detailed breakdown of "workLikelihood3years" for each gender
select gender,count(case when workLikelihood3years="Will work for 3 years or more" then 1 end)as Will_work_for_3yearsmore , count(case when workLikelihood3years="This will be hard to do, but if it is the right co" then 1 end)as  hard_to_do_but_willdo_rightco ,count(case when workLikelihood3years="No way" then 1 end)as No_way,count(case when workLikelihood3years="No way, 3 years with one employer is crazy" then 1 end)as No_way3yearswith_1employer from manager_aspirations
inner join personalized_info on manager_Aspirations.ResponseID=personalized_info.ResponseID
group by gender;
#ques 13 Give a detailed breakdown of "worklikelihood3years" for each country in india
select CurrentCountry,count(*) from manager_aspirations
inner join personalized_info on manager_Aspirations.ResponseID=personalized_info.ResponseID
where manager_aspirations.WorkLikelihood3Years not like "No%" 
group by CurrentCountry;
#ques14 What is average starting salary expectations at 3 year mark for each gender
select gender,avg(case
when  ExpectedSalary3Years between 11 and 15 then 11000
when ExpectedSalary3Years between 16 and 20 then 16000
when ExpectedSalary3Years between 21 and 25 then 21000
when ExpectedSalary3Years between 26 and 30 then 26000
when ExpectedSalary3Years between 31 and 40 then 31000
when ExpectedSalary3Years between 41 and 50 then 41000
when ExpectedSalary3Years between 50 and 10 then 5000
when ExpectedSalary3Years > 50 then 50000
end )as avg_high_value from mission_aspirations
inner join personalized_info on mission_Aspirations.ResponseID=personalized_info.ResponseID
group by gender;


#ques15 What is average starting salary expectations at 5 year mark for each gender
select gender,avg(case
when  ExpectedSalary5Years between 91 and 11 then 91000
when ExpectedSalary5Years between 71 and 90 then 71000
when ExpectedSalary5Years between 50 and 70 then 50000
when ExpectedSalary5Years between 30 and 50 then 30000
when ExpectedSalary5Years between 131 and 150 then 131000
when ExpectedSalary5Years between 111 and 130 then 111000
when ExpectedSalary5Years > 151 then 151000
end )as avg_high_value from mission_aspirations
inner join personalized_info on mission_Aspirations.ResponseID=personalized_info.ResponseID
group by gender;


#ques16 What is the Average Higher Bar Salary Expectations at 3 year mark for each gender
select gender,avg(case
when ExpectedSalary3Years between 11 and 15 then (11000+15000)/2
when ExpectedSalary3Years between 16 and 20 then (16000+20000)/2
when ExpectedSalary3Years between 21 and 25 then (21000+25000)/2
when ExpectedSalary3Years between 26 and 30 then (26000+30000)/2
when ExpectedSalary3Years between 31 and 40 then (31000+40000)/2
when ExpectedSalary3Years between 41 and 50 then (41000+50000)/2
when ExpectedSalary3Years between 50 and 100 then (5000+10000)/2
when ExpectedSalary3Years > 50 then 55000
end )as avg_high_value from mission_aspirations
inner join personalized_info on mission_Aspirations.ResponseID=personalized_info.ResponseID
group by gender;

#ques17 What is the Average Higher Bar Salary Expectations at 5 year mark for each gender
select gender,avg(case
when  ExpectedSalary5Years between 91 and 110 then (110000+91000)/2
when ExpectedSalary5Years between 71 and 90 then (90000+71000)/2
when ExpectedSalary5Years between 50 and 70 then (70000+50000)/2
when ExpectedSalary5Years between 30 and 50 then (50000+30000)/2
when ExpectedSalary5Years between 131 and 150 then (150000+131000)/2
when ExpectedSalary5Years between 111 and 130 then (130000+111000)/2
when ExpectedSalary5Years > 151 then 155000
end )as avg_high_value from mission_aspirations
inner join personalized_info on mission_Aspirations.ResponseID=personalized_info.ResponseID
group by gender;

#ques 18 What is average starting salary expectations at 3 year mark for each gender and each state in india
select currentcountry,gender, avg(case 
when  ExpectedSalary3Years between 11 and 15 then 11000
when ExpectedSalary3Years between 16 and 20 then 16000
when ExpectedSalary3Years between 21 and 25 then 21000
when ExpectedSalary3Years between 26 and 30 then 26000
when ExpectedSalary3Years between 31 and 40 then 31000
when ExpectedSalary3Years between 41 and 50 then 41000
when ExpectedSalary3Years between 50 and 10 then 5000
when ExpectedSalary3Years > 50 then 50000 end) from mission_aspirations
inner join personalized_info on mission_Aspirations.ResponseID=personalized_info.ResponseID
group by currentcountry,gender;
#ques 19 What is average starting salary expectations at 5 year mark for each gender and each state in india
select currentcountry,gender, avg(case when  ExpectedSalary5Years between 91 and 11 then 91000
when ExpectedSalary5Years between 71 and 90 then 71000
when ExpectedSalary5Years between 50 and 70 then 50000
when ExpectedSalary5Years between 30 and 50 then 30000
when ExpectedSalary5Years between 131 and 150 then 131000
when ExpectedSalary5Years between 111 and 130 then 111000
when ExpectedSalary5Years > 151 then 151000
end ) from mission_aspirations
inner join personalized_info on mission_Aspirations.ResponseID=personalized_info.ResponseID
group by currentcountry,gender;

#ques20 What is average Higher bar salary expectations at 3 year mark for each gender and each state in india
select Currentcountry,gender,avg(case
when ExpectedSalary3Years between 11 and 15 then (11000+15000)/2
when ExpectedSalary3Years between 16 and 20 then (16000+20000)/2
when ExpectedSalary3Years between 21 and 25 then (21000+25000)/2
when ExpectedSalary3Years between 26 and 30 then (26000+30000)/2
when ExpectedSalary3Years between 31 and 40 then (31000+40000)/2
when ExpectedSalary3Years between 41 and 50 then (41000+50000)/2
when ExpectedSalary3Years between 50 and 100 then (5000+10000)/2
when ExpectedSalary3Years > 50 then 55000
end )as avg_high_value from mission_aspirations
inner join personalized_info on mission_Aspirations.ResponseID=personalized_info.ResponseID
group by gender,Currentcountry;

#ques 21 What is average Higher bar salary expectations at 5 year mark for each gender and each state in india
select Currentcountry,gender,avg(case
when  ExpectedSalary5Years between 91 and 110 then (110000+91000)/2
when ExpectedSalary5Years between 71 and 90 then (90000+71000)/2
when ExpectedSalary5Years between 50 and 70 then (70000+50000)/2
when ExpectedSalary5Years between 30 and 50 then (50000+30000)/2
when ExpectedSalary5Years between 131 and 150 then (150000+131000)/2
when ExpectedSalary5Years between 111 and 130 then (130000+111000)/2
when ExpectedSalary5Years > 151 then 155000
end )as avg_high_value from mission_aspirations
inner join personalized_info on mission_Aspirations.ResponseID=personalized_info.ResponseID
group by gender,Currentcountry;
#ques22  give a detailed breakdown of the possibility of GenZ working for an Org if the "Mission is misaligned"for each State in india.
select Currentcountry,sum(case when MisalignedMissionLikelihood like "Will work%" then 1 else 0 end) from Mission_aspirations
inner join personalized_info on mission_Aspirations.ResponseID=personalized_info.ResponseID
group by Currentcountry;





