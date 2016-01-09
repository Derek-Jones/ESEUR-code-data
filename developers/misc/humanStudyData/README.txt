The files contained in this zip are as follows:

users.csv: the short list of 65 users we used in our study.  This list is paired down from the overall set of all users that completed any part of the study.  The columns in this file are as follows: {username,source_pool,start_time,end_time}

surveys.csv: answers to the exit survey on programming experience and additional qualitative thoughts.  For a list of corresponding questions, please see the actual online survey at 
http://church.cs.virginia.edu/~zpf5a/bugFinder/  
The columns in this file are as follows: {username,q1,q2,q3...} (all questions follow down the survey page in order)

votes.csv: a comma-seperated-value file that represents all of the human judgements made in the entire study.  NOTE: this contains all judgements collected, not just those that were used in the experiment.  Many values are missing due to incomplete responses; we include all data for the sake of completeness.  To obtain our data set, cross reference this file with users.csv  The columns in this file are as follows:  {username,code_file_number,is_bug?_answer,confidence_in_answer(1-5),perceived_difficulty_of_overall_file(1-5),line_of_bug_if_present,start_time,end_time}

pauses.csv: all recorded pauses.  Users were asked to pause the study whenever they were not directly attempting to complete a given question for the sake of recording accurate timing/effort data.  This pause data should be subtracted out from the timing data in votes.csv or users.csv if accurate time data is required.  Note: some do not include end times because of user error - in general these instances either correspond to to users that weren't used in the final results.  The columns in this file are as follows: {username,code_file_number,start_time,end_time}

===========================================

subjectCode/: this folder contains all of the subject code files we used in the study.  There are several subfiles/subfolders explained below.

numberToFilenameMapping.txt: mapping of code file to "code_file_number" (as was used in the csv files above to identify individual files) as well as the textbook it came from (see paper for references) and the progression through the book (1-10; corresponds to the "textbook difficulty" metric we use in our evaluation).  The columns in this file are as follows: {code_file_number,filename,book,textbook_difficulty}

withBugs/: this folder contains all files that were seeded with bugs.  In each case the line with the bug is clearly identified with a comment of the form:
//***(bug explanation)

withoutBugs/: this folder contains the files that were not seeded with bugs and acted as control instances in the human study.


