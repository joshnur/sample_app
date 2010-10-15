# Testing OpenCalais API

#------ Entity/Event/Relationships Documentation ----------------------------------------------------
# http://d.opencalais.com/1/pred/.html
# In the Oracle sues Google below, there is the about page,
# but it's referred to in the RDF response with an ending '\'.
# This should be replaced with '.html' and it becomes an accessible link on OpenCalais,
# describing Oracle and its structure:
# http://d.opencalais.com/er/company/ralg-tr1r/eab9bfaa-47f1-368a-a9b7-a87bb345cf30.html
#-----------------------------------------------------------------------------------------------------
# Just testing
# 0. Init
require 'Calais'
require 'pp'
   
@rdf_response = ''
MY_KEY = 'ab4m99h2dnxbv3pvf32h83n4'

# 1. Pseudo Tweets
username='user1' #unused here
tweet1="Oracle files lawsuit against Google over Java Intellectual Property $ORCL $GOOG"
tweet2="Yahoo rumoured to be acquired by AOL http://www.google.com/hostednews/afp/article/ALeqM5hE3yxCplGAn0agqYcHjsF5RLGzig?docId=CNG.bd6bd0d86d63f1a0e61b464e310712d2.df1"
timestamp= Time.now #unused here

# 2. Semantize the Tweet through OpenCalais

# Get Raw OpenCalais Response
# Try it with tweet2 instead and you'll see: Acquisition, datestring, date, company_beingacquired, status, type, company_acquirer
#                                            status: [announced, planned, cancelled, postponed, rumored, known, closed, new]
#                                            type: too many to mention here - refer to doc
@rdf_response = Calais.enlighten(:content => tweet1, :content_type => :raw, :license_id =>MY_KEY)

# 3. Capture Initial Tags, e.g. CompanyLegalIssues (this can be enhanced within a function or module)
h = {}
index1 = @rdf_response.index('terms of service.-->') # Strip extraneous stuff
index1 = @rdf_response.index('<!--', index1)
index2 = @rdf_response.index('-->', index1)
txt = @rdf_response[index1+4..index2-1]
lines = txt.split("\n")
lines.each {|line|
            index = line.index(":")
            h[line[0...index]] = line[index+1..-1].split(',').collect {|x| x.strip} if index
           }

# 5. Get RDF details e.g. Get company_sued, company_plaintiff, lawsuitclass (= class action or lawsuit)
# like within the tag: <!--CompanyLegalIssues: company_sued: Google; company_plaintiff: Oracle; lawsuitclass: lawsuit; -->

# ToDo

# 6. Display results

puts h #These are the main tags/semantics
puts "\n"

pp @rdf_response #This is what OpenCalais returns (for reference and study)
