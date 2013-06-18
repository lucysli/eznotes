# General Information #

## Project ##

EZNotes@McGillOSD

## Contact Info ##

McGill Office for Students with Disabilities  
Redpath Library Building, Suite RS56  
3459 McTavish Street  
Montreal, Quebec  
H3A 0C9  

514-398-6009

<http://www.mcgill.ca/osd/contact>

Andrew Bennett, B.A.  
Administrative Coordinator  
Email: andrew.bennett@mcgill.ca  

## Developers ##

Wisam Al Abed  
wisam.alabed@mail.mcgill.ca  
<http://ca.linkedin.com/in/wisamalabed>  

## Project Summary ##

What problem is this project solving?  

We are developing a web application that will match  
students with disabilities with prospective students  
taking the same course so that they can share their notes  
. TODO

## Technologies ##

### Framework ###
Rails

### Programming Language ###
-	Ruby
-	JQuery
-	Javascript
-	HTML

### Version Control ###
Git

### Database ###
PostgreSQL

### Testing/Development Deployment ###
Heroku <https://www.heroku.com/>

## Online tools ##
Wireframes <http://pencil.evolus.vn/>  
GitHub <https://github.com/mcgillosd/eznotes>  
-------------------------------------------
# Getting Started #

Almost everything was based on the rails guide by Michael Hartl <http://ruby.railstutorial.org/>. If you
are a first time rubist and this is your first rails app I recommend to read and follow the tutorial
thoroughly.

## Installing Ruby and Rails ##

for instally Ruby on OS X follow this link:  
<http://www.moncefbelyamani.com/how-to-install-xcode-homebrew-git-rvm-ruby-on-mac/#step-7>  

here is a summary

-	Step 1: Download and Install the Command Line Tools (via Xcode or the standalone installer)
-	Step 2: Verify that GCC was installed
-	Step 3: Install Homebrew
-	Step 4: Install Git
-	Step 5: Configure Git with your Name and Email
-	Step 6: Install RVM with the latest Ruby (2.0.0) and Rails (3.2.13)
-	Step 7: Load RVM into your shell session as a function
-	Step 8: Installing other versions of Ruby, such as 1.9.3

## Creating a Rails Application ##

`rails new` will create a skeleton Rails application in a directory of your choice. To get started, make a
directory for your Rails projects and then run `rails new` to make the first application.

### Summary of Rails Application Directory Structure ###

| **File/Directory**	| 												**Purpose**												 		 |
| ------------------ |:-------------------------------------------------------------------------------------:|
| app/					| Core application (app) code, including models, views, controllers, and helpers  		 |
| app/assets 			| Applications assets such as cascading style sheets (CSS), JavaScript files, and images|
| config/				| Application configuration 																			 	 |
| db/						| Database files 																								 |
| doc/					| Documentation for the application 																	 |
| lib/					| Library modules 																							 |
| lib/assets 			| Library assets such as cascading style sheets (CSS), JavaScript files, and images 	 |	
| log/					| Application log files 																					 |
| public/				| Data accessible to the public (e.g., web browsers), such as error pages 					 |
| script/Rails 		| A script for generating code, opening console sessions, or starting a local server 	 |
| test/					| Application tests (made obselete by the spec/ directory) 										 |
| tmp/					| Temporary files 																							 |
| vendor/				| Third-party code such as plugins and gems 															 |
| vendor/assets 		| Third-party assets such as cascading style sheets (CSS), JavaScript files, and images |
| README.rdoc 			| A brief description of the application( changed to README.md to use Github's markdown)|
| Rakefile 				| Utility tasks available via the `rake` command 													 |
| Gemfile 				| Gem requirements for this app 																			 |
| Gemfile.lock 		| A list of gems used to ensure that all copies of the app use the same gem versions 	 |
| config.ru 			| A configuration file for [Rack middleware](http://rack.rubyforge.org/doc/) 				 |
| .gitignore 			| Patterns for files that should be ignored by Git 												 |

## Using *Bundler* to install the included gems needed by the app ##
once you have assembed the proper and correct GemFile run  
$ `bundle update`  
$ `bundle install`  

## Running a local web server ##
use `rails server`. To see the result visit <http://localhost:3000/>  

# Setting up Git #

## First-time system setup ##
perform one time system setups.  
`$ git config --global user.name "Your Name"`  
`$ git config --global user.email your.email@example.com`  

if you like using `co` in place of the more verbose `checkout` command then run
`$ git config --global alias.co checkout`

## First-time repository setup ##
navigate to the root directory of your app and run  
`$ git init`

The next step is to add the project files to the repository. Git tracks all changes so if you want to ignore 
certain files then you need to edit .gitignore

## Adding and committing ##
`$ git add . `  

the . will add files recursively so it automatically includes subdirectories

`$ git status `

This command will tell you what changes are ready to be committed

`$ git commit -m "Initial commit"`  
This will perform a local commit on your machine. in order to commit to the remote repository like github you need to perform a `git push`

`$ git log`
will display the list of your commit messages

## GitHub ##
to push your application to GitHub type  
`$ git remote add origin https://github.com/<username>/first_app.git`  
`$ git push -u origin master`  

This command tells Git that you want to add GitHub as the origin for you main (master) branch and then push
your repository up to GitHub. Make sure to replace <username> with your actual username. For example the command i ran was:  
`$ git remote add origin https://github.com/ElectronMan/EZNotes.git`

note on most systems after performing the above command for the first time any further subsequent pushes we can 
omit origin and just run `$ git push`

# Deploying #
We are taking the approach of deploying our Rails application early and often to production in order to faciliate
catching any deployment problems early as opposed to deploying only at the end after much effort was put into
developing the app.

We are using Heroku to deploy our application which makes things easy as long as the source code is under version control with Git.

## Heroku Setup ##

Heroku uses PostfreSQL database we need to add pg gem to our GemFile.  

Now we have to configure a new Heroku account.
-	First [sign up for Heroku](https://id.heroku.com/signup)
-	Second install necessary Heroku software using [Heroku Toolbelt](https://toolbelt.heroku.com/)
-	Third use the heroku command to log in at the command line: `heroku login`
-	Fourth use the `heroku` command to create a place on the Heroku servers for your app to live:
		- `heroku create`

## Heroku Deployment, in one step ##
To deploy the application, use Git to push to Heroku  
`$ git push heroku master`

To open the web page deployed on Heroku you can run  
`$ git heroku open`

## Heroku commands ##
There are many [Heroku commands](https://devcenter.heroku.com/categories/command-line) you can use.
If you want to rename your application you can run  
`$ heroku rename EZNotes`. you can also change the name from your account on heroku.com

For development we generated a reasonably secure random/obscure subdomain such as hsjceevf.herokuapp.com.  
We did this by running `ruby -r "print ('a'..'z').to_a.shuffle[0..7].join"` on the command line.
-------------------------------------------
# Testing #
-------------------------------------------
# Staging and Production Environments #
-------------------------------------------