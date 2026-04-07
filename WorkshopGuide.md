
<a id="T_EF876BD9"></a>

# "MATLAB\-SimBiology\-DevOps\-Workflow\-Example" Workshop Guide

This workshop provides a step\-by\-step guide to generating automated tests using the MATLAB Unit Test Framework and MATLAB Test.


In this workshop, you will:

-  fork and modify your own copy of the "[MATLAB\-SimBiology\-DevOps\-Workflow\-Example](https://github.com/simkaryote/MATLAB-SimBiology-DevOps-Workflow-Example)" repository on GitHub 
-  generate tests using your command history and MATLAB Copilot 
-  automatically find and run existing tests 
-  explore code coverage metrics for your tested code 
-  automate your testing using continuous integration (CI) practices with GitHub Actions and build tool 

<!-- Begin Toc -->

## Table of Contents
&emsp;[Workshop Requirements](#H_34C2FB57)
 
&emsp;[Part 1:  Getting the workshop files and configuring GitHub for automated testing and results publishing](#TMP_1a20)
 
&emsp;[Part 2:  Generating your first tests](#TMP_7583)
 
&emsp;[Part 3:  Finding existing tests and measuring coverage](#TMP_114e)
 
&emsp;[Part 4:  Updating badges, committing our changes, and pushing to GitHub](#TMP_7fc1)
 
&emsp;[Part 5:  Create a pull request, watch GitHub Actions automatically test your changes and publish results](#TMP_6a0a)
 
&emsp;[Part 6:  Compile the App in the CI workflow and download the artifact](#TMP_0a1d)
 
&emsp;[Workshop wrap\-up and additional information](#TMP_195a)
 
<!-- End Toc -->
<a id="H_34C2FB57"></a>

# Workshop Requirements

The following steps cover all of the things you will need to successfully complete the workshop:


**A)  Access to MATLAB Online or a desktop MATLAB with the MATLAB Test*****™*** **product**

<a id="H_D43A4973"></a>
-  Go to:  [**https://matlab.mathworks.com**](https://matlab.mathworks.com/) 
-  *Note:*  If you do not have a MathWorks account, the above link will ask you to create an account for free 

**B)  Access to MATLAB Online or a desktop MATLAB with MATLAB Copilot**

-  *Note:*  If you do not have a license for MATLAB Copilot, you can simply skip that part of the workshop 

**C)  A GitHub account**

-  The workshop leverages the free repository and CI capabilities offered by GitHub and GitHub Actions 
-  Go to:  [**https://github.com/signup**](https://github.com/signup) 

<a id="TMP_1a20"></a>

# Part 1:  Getting the workshop files and configuring GitHub for automated testing and results publishing

In this section, you will:

1.  Fork the workshop files to your personal GitHub account
2. Enable GitHub Actions for automated testing
3. Enable GitHub Pages for report publishing
4. Open the workshop in MATLAB

<a id="TMP_35a2"></a>

**Part 1.1:  Fork the "Generating Tests for Your MATLAB Code Workshop" repository to your GitHub Account**


First, you'll start by forking the "[MATLAB\-SimBiology\-DevOps\-Workflow\-Example](https://github.com/simkaryote/MATLAB-SimBiology-DevOps-Workflow-Example)" repository to our own GitHub account.


**Wait... What does it mean to "fork a repository" and why should I do it?**


Forking a repository allows you to freely experiment with and push changes to a project without affecting the original project.


GitHub provides some great information about "why" and "how" to fork a repository here: [https://docs.github.com/en/enterprise\-cloud@latest/pull\-requests/collaborating\-with\-pull\-requests/working\-with\-forks/fork\-a\-repo](https://docs.github.com/en/enterprise-cloud@latest/pull-requests/collaborating-with-pull-requests/working-with-forks/fork-a-repo)


**However**, In our case, we will use forking as a way for everyone to have his/her own remote repository as everyone would be pushing the same changes to one single repo otherwise.


Since the forked repo is not meant to be pushed back to the original repository, we will make it standalone.


Let's get started!


**Go to:** [**https://github.com/simkaryote/MATLAB\-SimBiology\-DevOps\-Workflow\-Example**](https://github.com/simkaryote/MATLAB-SimBiology-DevOps-Workflow-Example)


![image_0.png](WorkshopGuide_media/image_0.png)

<a id="H_4B8B9F5D"></a>

**Press the "Fork" button (top right)**


![image_1.png](WorkshopGuide_media/image_1.png)

<a id="H_DB2C80D4"></a>

**Create your fork**


GitHub offers the ability to rename your copy of the repository, but this guide will assume the default name.


![image_2.png](WorkshopGuide_media/image_2.png)


***Notes:***

-  You may need to log into your GitHub account again during this step 
-  There's no problem with renaming your copy of the repository, but the rest of the workshop guide and screenshots assume the default repository name  


**Once you've forked the repository, you should see:**

-  your GitHub username at the top of your repository 
-  "forked from simkaryote/MATLAB\-SimBiology\-DevOps\-Workflow\-Example" 

![image_3.png](WorkshopGuide_media/image_3.png)


**Let's make it now standalone for the sake of the workshop.** 


![image_4.png](WorkshopGuide_media/image_4.png)


![image_5.png](WorkshopGuide_media/image_5.png)


Now your repository is standalone and not linked to the original repository. 


Before you go to MATLAB, let's enable some useful GitHub features that will be automatically triggered when we push our changes to GitHub later.

<a id="TMP_8dc4"></a>

**Part 1.2:  Enable GitHub Actions**


GitHub offers built\-in continuous integration (CI) services via their "GitHub Actions" feature. By default, GitHub Actions is disabled for forked repositories that contain a GitHub Actions YAML file, so you'll have to enable Actions before you can use them for the workshop. The workshop already provides a GitHub Actions YAML file to automatically test your code and publish test results so you can see them directly from your repository every time you push your code.


**Select the "Actions" tab**


![image_6.png](WorkshopGuide_media/image_6.png)


**Click the "I understand my workflows, go ahead and enable them" button**


![image_7.png](WorkshopGuide_media/image_7.png)


And that's it! GitHub Actions is now enabled for your repository.

<a id="TMP_2b25"></a>

**Part 1.3:  Enable GitHub Pages to publish our test results**


GitHub offers a built\-in way to publish test reports and artifacts created from your CI jobs. By default, GitHub Pages is disabled for new repositories, so we'll have to enable GitHub Pages before we can publish our test reports.


**Select the "Settings" tab**


![image_8.png](WorkshopGuide_media/image_8.png)


**Select the "Pages" entry on the left\-side navigation panel**


![image_9.png](WorkshopGuide_media/image_9.png)


**Change the "Build and deployment > Source" dropdown and select "GitHub Actions"**


![image_10.png](WorkshopGuide_media/image_10.png)


GitHub Pages is now enabled and your GitHub Actions will be allowed to publish test results for everyone to see.


**Part 1.4:  Add a protection rule to the main branch**


We put a protection rule on the main branch to follow the gold\-standard workflow: all changes come in via pull requests, get reviewed, and pass the tests before they land, so main always stays in a good, working state.


![image_11.png](WorkshopGuide_media/image_11.png)


![image_12.png](WorkshopGuide_media/image_12.png)


![image_13.png](WorkshopGuide_media/image_13.png)


![image_14.png](WorkshopGuide_media/image_14.png)

<a id="TMP_1ab2"></a>

**Part 1.5:  Open the workshop in MATLAB Online or in your MATLAB Desktop**


*Notes:* 

-  You may also do this workshop using a desktop MATLAB with the MATLAB Test product installed. 
-  If you do not have the MATLAB Test product, you will not see the right\-click menu items and buttons described below 


Let's get started!


**Go to:** [**https://matlab.mathworks.com**](https://matlab.mathworks.com)

-  *Note:*  If you do not have a MathWorks account, you will need to create one before continuing. 

<a id="H_4B8B9F5D"></a>

**Get the workshop files selecting Home > New > Git Clone**


![image_15.png](WorkshopGuide_media/image_15.png)

<a id="H_DB2C80D4"></a>

**Enter the URL of your GitHub repository in the dialog and hit "Clone"**


![image_16.png](WorkshopGuide_media/image_16.png)


 


**Open the workshop project by double\-clicking on the** [**`DevOps.prj`**](./DevOps.prj) **file**


A MATLAB project is a useful tool that makes it easy to:

-  automatically set up your path consistently across multiple users and machines 
-  run startup and shutdown scripts when you open or close the project 
-  keep one project from affecting the environment of another project 

![image_17.png](WorkshopGuide_media/image_17.png)


**Give MATLAB permission to run project startup tasks**


As part of our commitment to security, MATLAB will ask you for permission before executing any code during project startup the first time you open a project.


For this workshop, the code we are executing during project startup is to automatically open the workshop guide ([`WorkshopGuide.m`](./WorkshopGuide.m)) for you when you open the project.


In the following dialog, please select "Open" to open the project and run this startup task.


![image_18.png](WorkshopGuide_media/image_18.png)


Your MATLAB now should look something like this:


![image_19.png](WorkshopGuide_media/image_19.png)


*Notes:* 

-  You will not see the "Copilot Chat" panel on the right if you do not have access to MATLAB Copilot 


**Part 1.6:  Switch to a development branch**


After cloning the repo, you will be seeing the default main branch.


It is good practice to create a new branch and switch to it to make new development, push it to your remote repo and merge your branch with the main branch (more on this later...).


Let's open the branch manager from the "Project" tab:


![image_20.png](WorkshopGuide_media/image_20.png)


And create a new `dev` branch and switch to it:


![image_21.png](WorkshopGuide_media/image_21.png)


![image_22.png](WorkshopGuide_media/image_22.png)


Now you're ready to work on your project and, for example, start generating tests!


**Part 1.7:  Let's run the app!**


Click on the 'Run App' shortcut to start the app in MATLAB:


![image_23.png](WorkshopGuide_media/image_23.png)


![image_24.png](WorkshopGuide_media/image_24.png)


<a id="TMP_7583"></a>

# Part 2:  Generating your first tests

In this section, you will:

1.  Generate tests using your command history
2. Generate tests using MATLAB Copilot
3. Add generated tests to your project

<a id="TMP_684d"></a>

**Part 2.1: Generating your first test using Command History**


**Open the** [**`SimulationModel`**](./code/SimulationModel.m) class **(found in the code folder)**

```matlab
edit SimulationModel.m
```


**Interactively test** [**`SimulationModel`**](./code/SimulationModel.m) **using the MATLAB Command Window**


Here's an example code you can run at the Command Window:

```
sObj = SimulationModel;
simulate(sObj);
sbioplot(sObj.SimData);
isa(sObj.SimData, 'SimData')
all(ismember(sObj.SimData.DataNames,["Drug","Receptor","Complex","RO"]))
```

![image_25.png](WorkshopGuide_media/image_25.png)


**Generate your first test for the** [**`SimulationModel`**](./code/SimulationModel.m) class **using our command history**


While we could start creating a test from scratch, wouldn't it be nice if we could reuse the interactive testing we did at the Command Window?


As of MATLAB R2025a, MATLAB Test introduced a feature to generate a test from your command history.


**Go to the Command History panel**


![image_26.png](WorkshopGuide_media/image_26.png)


*Note:*  If you don't see the Command History panel icon, you can add the icon by selecting the "`...`" option and selecting the "Command History" item.


![image_27.png](WorkshopGuide_media/image_27.png)


![image_28.png](WorkshopGuide_media/image_28.png)


*Note:*  You can also access your command history by pressing the "up" key while at the MATLAB Command Window.


**Right\-Click one of your calls** **and select "Generate Test"**


![image_29.png](WorkshopGuide_media/image_29.png)



This will automatically gather all relevant code lines needed to execute that command successfully and generate a test template for you:


![image_30.png](WorkshopGuide_media/image_30.png)


**Check that both assertions are true and rename the class and the test**


![image_31.png](WorkshopGuide_media/image_31.png)


**Save your test to the** **`tests`** **folder**


![image_32.png](WorkshopGuide_media/image_32.png)


**Run your test using the "Run Tests" button in the Editor toolstrip**


![image_33.png](WorkshopGuide_media/image_33.png)


As of MATLAB R2023a, running tests from the Editor toolstrip will automatically open the MATLAB Test Browser.


The MATLAB Test Browser makes it easy to:

-  rerun tests without being in the test file 
-  explore test failure diagnostics 
-  filter results based on test status (pass, fail, incomplete) 
-  enable code coverage 
-  enable parallel test execution 

![image_34.png](WorkshopGuide_media/image_34.png)


After your tests are done running, you will be able to to quickly see that your tests have passed. Yay!


<a id="TMP_9172"></a>

**Part 2.2:  Generate tests using MATLAB Copilot**


As of MATLAB R2025a, MATLAB now offers MATLAB Copilot (requires a separate license) that enables GenAI capabilities optimized for MATLAB code. As with most platforms, we have a MATLAB Copilot chat panel to use AI in a conversational way.


To make testing even easier, MATLAB Test enables 1\-click buttons to automatically generate tests for the code you are looking at.


*Note:* Only the "Generate test for the current file using Copilot" option uses MATLAB Copilot. All other test generation options do not use any LLM technology and create tests using templates and static code analysis.



**Go back to** [**`SimulationModel.m`**](./code/SimulationModel.m)

```matlab
edit SimulationModel.m
```


**In the Editor toolstrip, expand the "Generate Test" drop down menu and select "Generate test for the current file using MATLAB Copilot"**


![image_35.png](WorkshopGuide_media/image_35.png)



MATLAB Copilot will generate multiple ready\-to\-run tests.


![image_36.png](WorkshopGuide_media/image_36.png)


*Note:*  As with all LLM\-based technologies, remember to validate the output before using it in production systems.



**Save and run your generated tests**


Just like before, save your new tests to the `tests` folder and run your tests.


![image_37.png](WorkshopGuide_media/image_37.png)


 **Look at your test results in the MATLAB Test Browser**

-  *Note:*  Depending on the tests MATLAB Copilot generates, you may or may not end up with some failing tests. 

![image_38.png](WorkshopGuide_media/image_38.png)



The test done on lines 29 & 30 in `testSimulateFunction` does not seem right. Let's delete those lines and rerun the test.


![image_39.png](WorkshopGuide_media/image_39.png)


![image_40.png](WorkshopGuide_media/image_40.png)


<a id="TMP_22e2"></a>

**Part 2.3:  Add generated tests to your project**


When you create a new file directly from the Project side panel, the file is automatically added to the project and to source control.


However, when you create a new file in another way (e.g., "New > Function," the "+" button on the Editor's tab toolbar, or the test generation options), MATLAB leaves it up to you to decide whether or not to include the file in your project.


Let's add our 2 new test files to the project


**Find your new test files in the** **`tests`** **folder using the Project side panel**


Go back to the Project side panel.


You can identify files not in your project when the Status column is not a check mark or the Git column is an empty circle.


![image_41.png](WorkshopGuide_media/image_41.png)


**Right\-click the test files and select "Add to Project"**


![image_42.png](WorkshopGuide_media/image_42.png)


**Confirm your test files have been added to the project by seeing the check mark in the Status column and the "+" icon in the Git column**


![image_43.png](WorkshopGuide_media/image_43.png)


Congratulations! You just created multiple tests for your MATLAB code!


It was easier than you thought, right?

<a id="TMP_114e"></a>

# Part 3:  Finding existing tests and measuring coverage

In this section, you will:

1.  Find existing tests for [`generateSimFun.m`](./code/generateSimFun.m)
2. Enable and explore code coverage
3. Identify missing coverage
4. Add a test point to an existing test file

<a id="TMP_2630"></a>

**Part 3.1:  Finding existing tests for a code file**


When working with a new codebase or making changes to an existing file, you should run any existing tests that exercise that function to make sure you haven't broken anything.


But this raises several questions:

-  Are there are any existing tests? 
-  Where are the tests? 
-  Should we just run all the tests? 
-  How do we know which tests (or if any tests) actually exercise the code we are working on? 


In MATLAB R2025a, MATLAB Test introduced a "Find Tests" feature that automatically finds any tests related to the file you are looking at and ignores any tests that are not related to this file.


Let's see how this works using the [`generateSimFun`](./code/generateSimFun.m) function:

```matlab
edit generateSimFun.m
```


**Press the "Find Tests" button in the Editor toolstrip**


![image_44.png](WorkshopGuide_media/image_44.png)


**Select the root of your project to identify all tests in your project** 

-  *Note:* This root of your project is the default location, so you can just choose "OK" 

MATLAB automatically will perform a dependency analysis on `generateSimFun`.


![image_45.png](WorkshopGuide_media/image_45.png)


After the dependency analysis, you will see several tests that are related to `generateSimFun` open in the MATLAB Test Browser.


![image_46.png](WorkshopGuide_media/image_46.png)


**Run the tests in the MATLAB Test Browser using the MATLAB Test Browser's "Run" button**


![image_47.png](WorkshopGuide_media/image_47.png)


It looks like all the tests passed! Yay!


![image_48.png](WorkshopGuide_media/image_48.png)


<a id="TMP_7b6c"></a>

**Part 3.2:  Using code coverage to understand how much of your code is being exercised by your tests**


It was great that we already had tests for [`generateSimFun`](./code/generateSimFun.m), but how much of [`generateSimFun`](./code/generateSimFun.m) is being exercised by those tests?


"Code coverage" is a way to measure how much and which parts of your code have been exercised by tests.


There are several types of code coverage metrics:

-  Statement coverage:  Measure which statements have been executed 
-  Decision coverage:  Measures whether both `true` and `false` conditions have been exercised for logical branches (e.g., `if`, `switch/case`) 
-  Condition coverage:  When logical branches are composed of multiple logical conditions (e.g., `x > 5 && x < 10`), this measures whether each logical statement that is part of the `if` statement has been exercised for both `true` and `false` values 
-  Modified Condition/Decision Coverage (MC/DC):  A modified set of decision + condition coverage metrics that is primarily used in code certification processes 

*Note:*  Decision, Condition, and MC/DC metrics require MATLAB Test.


The MATLAB Unit Test Framework can automatically measure code coverage, but it is off by default, so let's enable code coverage!


**Open code coverage settings**


![image_49.png](WorkshopGuide_media/image_49.png)


**Enable coverage reporting**


![image_50.png](WorkshopGuide_media/image_50.png)



**Select the "Condition" coverage metric**


![image_51.png](WorkshopGuide_media/image_51.png)


*Note:*  For this workshop, we will skip MC/DC since it is a significantly more advanced topic and primarily used in certification workflows.



**Add the** **`code`** **folder to the "Source" list**


By selecting specific files or folders, we can focus our code coverage measurements on only the files and folders you select and avoid complicating our code coverage reports with code that is less critical for our application.


![image_52.png](WorkshopGuide_media/image_52.png)



**Deselect "Open coverage report after run"**


While this option can conveniently open the coverage report after every test run, it can sometimes be distracting when you are rerunning tests frequently.


![image_53.png](WorkshopGuide_media/image_53.png)


**Close the Coverage Settings**


![image_54.png](WorkshopGuide_media/image_54.png)


**Rerun your tests**


![image_55.png](WorkshopGuide_media/image_55.png)


**Click the link in the Command Window to open the code coverage report**


![image_56.png](WorkshopGuide_media/image_56.png)


You should see a Code Coverage Report very similar to the one below.


![image_57.png](WorkshopGuide_media/image_57.png)


The top of the report gives you an overall summary of the coverage metrics for all of the code in the folders you have chosen, while the "Breakdown by Source" table gives you a breakdown of the coverage metrics by file.


For this workshop, we will focus on the "Breakdown by Source" and the detailed coverage inside the code files.


<a id="TMP_4d1c"></a>

**Part 3.3:  Identifying testing gaps (and potential bugs) for** [`generateSimFun`](./code/generateSimFun.m) **using code coverage**


Let's look at the detailed coverage metrics for the [`generateSimFun`](./code/generateSimFun.m) file and and see which parts of the code have been exercised.


**Select the** [`generateSimFun.m`](./code/generateSimFun.m) **row in the "Breakdown by Source" table**


![image_58.png](WorkshopGuide_media/image_58.png)



**Scroll down to see the detailed source code and coverage metrics**


![image_59.png](WorkshopGuide_media/image_59.png)


Well, that seems like a rather boring detailed report, right?


The reason you don't really see any interesting data in Source Details is because you are looking at the "Condition" coverage metric, but [`generateSimFun`](./code/generateSimFun.m) is a very simple code with no conditions in its logical branches. You can also see that the "Condition" column is empty, which is another clue for why the source details look empty.


However, you can see that the Statement and Decision columns have data in them, so let's take a look at those coverage metrics.


**Select "Decision" coverage in the "Currently viewing" overlay at the top of the page**


Now the coverage report looks much more interesting!


![image_60.png](WorkshopGuide_media/image_60.png)


There are several kinds of highlights you can see in the source code:

-  Green:  Both `true` and `false` decisions have been exercised 
-  Yellow:  Only one of the `true` or `false` decisions have been exercised 
-  Red:  None of the `true` or `false` decisions have been exercised 

*Note:*  The coverage report does not have any red because all of the decision branches have been at least partially exercised by at least one test


In addition to the source code highlights, the "Decision" column shows how many times each decision outcome (`true` and `false`) has been exercised by your tests. You can use these numbers to identify which condition outcome you did not exercise or help you decide whether you want to exercise a specific code branch more times.


We can also take a look at the "Statement" coverage metrics to see which statements in our code have and have not been exercised by our tests.


**Select "Statement" coverage in the "Currently viewing" overlay at the top of the page**


![image_61.png](WorkshopGuide_media/image_61.png)


From the highlights, we can see that line 4 of our code has never been exercised by our tests.


Now you can ask the questions:

-  Do I just need an extra test to exercise this piece of the code? 
-  Is this code unreachable (i.e., is it "dead code") and can be removed? 
-  Or is this a symptom of a bug in our code? 


**Part 3.4:  Add an additional automated test point for** [`generateSimFun`](./code/generateSimFun.m) 


**Open the test file for** [`generateSimFun`](./code/generateSimFun.m) **and add another test point**


Wait... Where is the test file for [`generateSimFun`](./code/generateSimFun.m) ? You never actually saw the test file because you found the tests using "Find Tests."


Luckily, the MATLAB Test Browser makes it easy to open the test files related to each test by simply clicking on the test file name. In this case, all of the test points are located in the [`tgenerateSimFun.m`](./tests/tgenerateSimFun.m) file.


![image_62.png](WorkshopGuide_media/image_62.png)



This is what the test file looks like:


![image_63.png](WorkshopGuide_media/image_63.png)


Hm... This seems a bit different than the tests we saw before. The MATLAB Test Browser showed 5 tests, but this test file looks like it only has 3 tests in it.


What's going on here?


The answer:  The second test in [`tgenerateSimFun.m`](./tests/tgenerateSimFun.m) is a parameterized test.



**Understanding parameterized tests**


A parameterized test is a kind of test that enables you to reuse a single test function across multiple test points (i.e., across multiple inputs).


Parameterized tests are extremely useful when:

-  you need to test a code multiple times with multiple inputs 
-  the calling syntax is the same across multiple tests 
-  the verifications are the same across multiple tests 


The way a parameterized test works is by defining a test parameter (or multiple test parameters) that contain the inputs you want to pass into your code, and passing that test parameter to your test function.


![image_64.png](WorkshopGuide_media/image_64.png)


Looking at the second test function, you can see it takes this test parameter as an additional input. This test parameter will have a different value every time the function is called.


![image_65.png](WorkshopGuide_media/image_65.png)


*Note:* You can learn more about parameterized testing here:  [https://www.mathworks.com/help/matlab/matlab\_prog/use\-parameters\-in\-class\-based\-tests.html](https://www.mathworks.com/help/matlab/matlab_prog/use-parameters-in-class-based-tests.html)


Similarly, parameters can be used in other methods such as `classSetup`, which is a method that is called once before running all tests.


![image_66.png](WorkshopGuide_media/image_66.png)


![image_67.png](WorkshopGuide_media/image_67.png)


**Add another test point**


To add another test point, you need to add another value to the `MATfilename` ClassSetupParameter cell array.


To do this, you can replace the following code:

```
MATfilename = {"test_generateSimFun.mat"}
```

with:

```
MATfilename = {"test_generateSimFun.mat", string.empty}
```

**Rerun your tests and look at the coverage report**


*Note:*  You must use the "Run Tests" button in the Editor toolstrip to to pick up the new test point we added. The "Run" button in the MATLAB Test Browser will only run the tests that are loaded in the panel. It will not automatically pick up new tests in the files.


![image_68.png](WorkshopGuide_media/image_68.png)


It looks like we've achieved full statement coverage for [`generateSimFun`](./code/generateSimFun.m). Yay!


![image_69.png](WorkshopGuide_media/image_69.png)


<a id="TMP_7fc1"></a>

# Part 4:  Updating badges, committing our changes, and pushing to GitHub

In this section, you will:

1.  Update the repository badges in [`README.md`](./README.md)
2. Commit our changes to source control
3. Generate a GitHub Personal Access Token
4. Push our changes to GitHub

<a id="TMP_4476"></a>

**Part 4.1:  Update repository badges**


![image_70.png](WorkshopGuide_media/image_70.png)


Repository badges are great ways to showcase and allow exploration of the quality of your code. Badges are defined in a repository's [`README.md`](./README.md).


One unfortunate aspect of badges is that they are always hardcoded to a specific repository's URL. Since you forked these badges from another repository, you will need to update the badge so they point to your repository instead.


To make this easy, the workshop provides a useful project shortcut that will automatically update the links in your [`README.md`](./README.md) file.


**Update the badges by single\-clicking the "Update README Link" item in the "Shortcuts" section of the Project toolstrip**


![image_71.png](WorkshopGuide_media/image_71.png)


*Note*: If you want to manually update the links, you will need to make the following changes to all of the links in the [`README.md`](./README.md) file:

-  replace the "simkaryote" GitHub username with your GitHub username 
-  if you renamed the repository during the fork process in [Part 1.1](#H_DB2C80D4), replace "MATLAB\-SimBiology\-DevOps\-Workflow\-Example" repository name with your GitHub repository name 


Your badges will now be up\-to\-date and point to your personal repository once you commit and push your changes.


<a id="TMP_917f"></a>

**Part 4.2:  Commit our changes to source control**


Now that you've added tests, and updated your badges, it's time to commit your changes !


**In the "Project" toolstrip, press "Commit"**


![image_72.png](WorkshopGuide_media/image_72.png)


**Type in a useful commit message and press "Commit"**


![image_73.png](WorkshopGuide_media/image_73.png)



You have now committed your changes.


Usually, the next step is to push our changes back to GitHub. This is really easy and straightforward when using Git from a desktop application (e.g., the desktop version of MATLAB). If we are pushing our changes from an online application like MATLAB Online, or if you don't have the Git Credential Manager on your machine, GitHub requires a personal access token to allow MATLAB Online to make changes to your GitHub repository.



**Part 4.3:  Generating a GitHub Personal Access token to enable MATLAB Online to push our changes to our GitHub repository** 

<a id="TMP_5ea8"></a>

**(only needed if you use MATLAB Online, SKIP if you use a desktop MATLAB installation !)**


 ![image_74.png](WorkshopGuide_media/image_74.png)


Over the last few years, GitHub has increased its focus on security. One of the major user\-facing ways GitHub is enforcing some of these better security practices is by [moving away from the use of passwords](https://github.blog/2020-07-30-token-authentication-requirements-for-api-and-git-operations/), and recommending that people use personal access tokens instead.

<a id="H_CBDCBEA6"></a>

Personal access tokens are meant to be treated like passwords:

-  They are supposed to be difficult or impossible to memorize or guess 
-  They are not meant to be written down 
-  They are not meant to be shared with others 


When you install Git on your desktop, it comes with the Git Credential Manager. The Git Credential Manager will accept a username/password combination, it will securely get and store a personal access token for you, and it will make it very easy to push and pull changes without manually generating a personal access token.


For a MATLAB Online session or other situations, you will need to manually create a personal access token to give MATLAB Online permission to push changes to your GitHub repository. GitHub provides directions for [how to create a personal access token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token), but this part of the workshop will give you a step\-by\-step guide to creating your own personal access token.


<a id="H_7AE18FA9"></a>

**On GitHub, press your profile picture (top right of the page) and select "Settings"**


 ![image_75.png](WorkshopGuide_media/image_75.png)


**Select "Developer settings" at the bottom of the left\-hand navigation menu**


 ![image_76.png](WorkshopGuide_media/image_76.png)


**Select "Personal access tokens > Fine\-grained tokens"**


 ![image_77.png](WorkshopGuide_media/image_77.png)

<a id="H_B96DECF2"></a>

**Press "Generate new token"**


![image_78.png](WorkshopGuide_media/image_78.png)


***Note:***  You may need to log into GitHub again to complete this action.


<a id="H_8CAA78FC"></a>

**Name your token**


![image_79.png](WorkshopGuide_media/image_79.png)



**Limit token access to only the workshop repo**


![image_80.png](WorkshopGuide_media/image_80.png)



**Select "Add Permissions > Contents + Workflows" to enable pushing changes to your repository**


![image_81.png](WorkshopGuide_media/image_81.png)


![image_82.png](WorkshopGuide_media/image_82.png)


**Change "Contents" access permissions to "Read and write"**


![image_83.png](WorkshopGuide_media/image_83.png)


<a id="H_2C284494"></a>

**Press "Generate token"**


![image_84.png](WorkshopGuide_media/image_84.png)



**Confirm the creation of the token**


![image_85.png](WorkshopGuide_media/image_85.png)


**Copy your personal access token to your clipboard**


***WARNING:***

-  You only have 1 chance to copy the personal access token, so do not navigate away from the page until you have used the token wherever you need it 
-  If you forget to copy your token string or you need to give another service access to your repository at a later time, you will need to create a new token 


Any service that generates access token strings will only allow you to see or copy the token string the moment the token is created. As soon as you refresh the page or navigate away, the token string will be hidden forever. This protects you from having your token stolen or copied if someone breaks into your account.


![image_86.png](WorkshopGuide_media/image_86.png)


Your personal access token should start with "`github_pat_`" followed by many alphanumeric characters.


<a id="TMP_4b5c"></a>

**Part 4.4:  Pushing your changes to GitHub**


Now let's push your changes to GitHub!


**In the Projects tab, press the "Push" button**


![image_87.png](WorkshopGuide_media/image_87.png)

<a id="H_D0E7BA3D"></a>

**Enter your username and paste your personal access token into the MATLAB Online Git dialog and press "OK"**


![image_88.svg](WorkshopGuide_media/image_88.svg)



At this point, all of your changes will be pushed to GitHub.


![image_89.png](WorkshopGuide_media/image_89.png)


<a id="TMP_6a0a"></a>

# Part 5:  Create a pull request, watch GitHub Actions automatically test your changes and publish results

In this section, you will:

1.  Create a pull request
2. Explore GitHub Actions as it automatically tests your changes and publishes test results
3. View your published test and code coverage results

**Part 5.1:  Create a pull request to merge your new code into the main branch**


After pushing your new branch to the remote repo, it will automatically suggest to create a pull request:


 ![image_90.png](WorkshopGuide_media/image_90.png)


You can follow this suggestion and click on the 'compare & pull request" button:


![image_91.png](WorkshopGuide_media/image_91.png)


You can now add a description and press "Create pull request".


This will trigger a CI workflow to run our tests on the dev branch:


![image_92.png](WorkshopGuide_media/image_92.png)


<a id="TMP_2df5"></a>

**Part 5.2:  Watch GitHub Actions automatically test your code** 


Once you start the pull request, GitHub Actions will automatically test your code.


To make this possible, the workshop provides you a pre\-written [GitHub Actions YAML file](..github/workflows/ci.yml) that tells GitHub Actions how to get MATLAB and what to do with your code as soon as changes are pushed.

-  You can learn more about GitHub Actions YAML files here:  [https://docs.github.com/en/actions/reference/workflows\-and\-actions/workflow\-syntax](https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-syntax) 


*Notes:*

-  We are using the MATLAB build tool to automate some of the build actions, but all of these actions can be accomplished with simple MATLAB code, as well. 
-  You can learn more about the MATLAB build tool here:  [https://www.mathworks.com/help/matlab/matlab\_prog/overview\-of\-matlab\-build\-tool.html](https://www.mathworks.com/help/matlab/matlab_prog/overview-of-matlab-build-tool.html) 


**Click on the check to open the corresponding job run in the Action tab:**


![image_93.png](WorkshopGuide_media/image_93.png)


You will see the different steps included in this job:


![image_94.png](WorkshopGuide_media/image_94.png)


Once the tests ran successfully in the dev branch, you can merge the pull request:


![image_95.png](WorkshopGuide_media/image_95.png)


In the Actions Tab, we will see the list of all job runs including the current one:


![image_96.png](WorkshopGuide_media/image_96.png)

<a id="H_FBE3C756"></a>

**Dive deeper by selecting the listed workflow item and Select the "build" box**


![image_97.png](WorkshopGuide_media/image_97.png)



**Observe the GitHub Actions log as your build is running**


![image_98.png](WorkshopGuide_media/image_98.png)



The icon next to the build reflects the result of the build. A green check mark means the build ran successfully.


![image_99.png](WorkshopGuide_media/image_99.png)



Another place you can see an indication of your passing build is on your repository home page.


![image_100.png](WorkshopGuide_media/image_100.png)


*Note:*  You may need to refresh your browser a few times or use "Shift+F5" for the status to update



You now have a repository that will automatically test your code every time you push any changes!


<a id="TMP_99e6"></a>

**Part 5.3:  Viewing your test and coverage results directly in GitHub**


Once your build completes, anyone that can see your repository will be able to explore your published test and code coverage results.


The badges on your repository's home page offer an easy way to:

-  See whether your last build passed or failed 
-  Open the published test report 
-  Open the published code coverage report 


*Note:*  Badge links will navigate your current browser tab to the link destination, so you will need to navigate back to the main repository page to select a different badge or report


<a id="H_C2E2595D"></a>

**View your test report by selecting the "Open Test Report" badge**


![image_101.png](WorkshopGuide_media/image_101.png)


The test report looks like this:


![image_102.png](WorkshopGuide_media/image_102.png)


<a id="H_C2E2595D"></a>

**View your code coverage report by selecting the "Open Code Coverage Report" badge**


![image_103.png](WorkshopGuide_media/image_103.png)


The code coverage report looks like this:


![image_104.png](WorkshopGuide_media/image_104.png)



Now anyone that visits your repository can immediately see the quality of your code, explore your test and code coverage results, and will have more confidence in the code you are writing!

<a id="TMP_0a1d"></a>

# Part 6:  Compile the App in the CI workflow and download the artifact

So far, we have only triggered tests and generated reports/badges. We were able to use free GitHub runner and licensing in our public repo.


However, our final goal is to compile our app into a web app. For this we will need a license of MATLAB Compiler. This will be provided by a BATCH TOKEN.


In this section, you will:

1.  Add a batch token to your repository
2. Modify the CI workflow to include a compilation step
3. Download the resulting CTF file

**Part 6.1:  Add a batch token to your repository**


Open the settings tab


![image_105.png](WorkshopGuide_media/image_105.png)


On the left side, choose "Secrets and variables" \-> Actions


![image_106.png](WorkshopGuide_media/image_106.png)


Let's add a new repository secret:


![image_107.png](WorkshopGuide_media/image_107.png)


Create now a new secret named MLM\_LICENSE\_TOKEN by pasting the secret we provided for this workshop:


![image_108.png](WorkshopGuide_media/image_108.png)


It should now look like this:


![image_109.png](WorkshopGuide_media/image_109.png)


**Part 6.2:  Modify the CI workflow to include a compilation step**


Let's now activate the compilation step in our CI workflow.


For this, go back to MATLAB and open the ci.yml file using the project shortcut:


![image_110.png](WorkshopGuide_media/image_110.png)


Change line 94 from

```
          tasks: test  # change to compile
```

to

```
          tasks: compile  # change to compile
```

And uncomment line 109 to 113:

```
      # Upload compiled CTF file to deploy Web App
      - name: Upload CTF file
        uses: actions/upload-artifact@v6
        with:
          name: WebApp_CTF
          path: WebAppArchive/*.ctf
```

Let's now commit these changes and push to your remote repo.


There, start a pull request!


**Part 6.3:  Download the resulting CTF file**


Once the `Deploy/ Release (main)` job is done, a new artifact is available at the bottom of the run page:


![image_111.png](WorkshopGuide_media/image_111.png)


You can now download the CTF file and upload it to your Web App Server!

<a id="TMP_195a"></a>

# Workshop wrap\-up and additional information

Congratulations! You've completed the Workshop!


**During this workshop, you have successfully:**

-  generated tests using your command history and MATLAB Copilot 
-  automatically found and ran existing tests 
-  explored code coverage metrics for your tested code 
-  identified bugs based on your testing and code coverage 
-  automated your testing using GitHub Actions 
-  published your test and code coverage results to GitHub Pages 


We hope this workshop has shown you the value of software testing, how approachable software testing is with MATLAB and MATLAB Test, and how to automate testing using continuous integration (CI) practices.


**Check out these links for more information about features we discussed and additional features that may help as you test your code:**

-  Software testing video series:  [https://www.mathworks.com/videos/series/software\-testing.html](https://www.mathworks.com/videos/series/software-testing.html) 
-  Generating tests with MATLAB Test:  [https://www.mathworks.com/help/matlab\-test/ug/generate\-tests\-for\-matlab\-source\-code.html](https://www.mathworks.com/help/matlab-test/ug/generate-tests-for-matlab-source-code.html) 
-  Generating equivalence tests for automated C/C++ code generation:  [https://www.mathworks.com/help/matlab\-test/ug/generate\-c\-code\-and\-test\-for\-equivalence.html](https://www.mathworks.com/help/matlab-test/ug/generate-c-code-and-test-for-equivalence.html) 
-  Parameterized testing:  [https://www.mathworks.com/help/matlab/matlab\_prog/use\-parameters\-in\-class\-based\-tests.html](https://www.mathworks.com/help/matlab/matlab_prog/use-parameters-in-class-based-tests.html) 
-  Property\-based testing:  [https://en.wikipedia.org/wiki/Software\_testing\#Property\_testing](<https://en.wikipedia.org/wiki/Software_testing#Property_testing>) 
-  Finding existing tests using "Find Tests":  [https://www.mathworks.com/help/matlab\-test/ug/find\-tests\-that\-depend\-on\-files.html](https://www.mathworks.com/help/matlab-test/ug/find-tests-that-depend-on-files.html) 
-  MATLAB Test Browser:  [https://www.mathworks.com/help/matlab/ref/testbrowser\-app.html](https://www.mathworks.com/help/matlab/ref/testbrowser-app.html) 
-  Code coverage:  [https://www.mathworks.com/help/matlab\-test/ug/collect\-code\-coverage\-metrics\-for\-matlab\-source\-code.html](https://www.mathworks.com/help/matlab-test/ug/collect-code-coverage-metrics-for-matlab-source-code.html) 
-  CI Configuration Examples repository and badge examples:  [https://github.com/mathworks/ci\-configuration\-examples](https://github.com/mathworks/ci-configuration-examples) 
-  Creating a MATLAB docker container for CI:  [https://github.com/mathworks\-ref\-arch/matlab\-dockerfile/tree/main/alternates/non\-interactive](https://github.com/mathworks-ref-arch/matlab-dockerfile/tree/main/alternates/non-interactive) 
-  MATLAB build tool overview:  [https://www.mathworks.com/help/matlab/matlab\_prog/overview\-of\-matlab\-build\-tool.html](https://www.mathworks.com/help/matlab/matlab_prog/overview-of-matlab-build-tool.html) 
-  MATLAB build tool introduction blog post:  [https://blogs.mathworks.com/developer/2022/10/17/building\-blocks\-with\-buildtool](https://blogs.mathworks.com/developer/2022/10/17/building-blocks-with-buildtool/) 
-  Faster testing with MATLAB build tool blog post:  [https://blogs.mathworks.com/developer/2025/07/02/test\-impact\-analysis\-intro](https://blogs.mathworks.com/developer/2025/07/02/test-impact-analysis-intro) 
-  Developer Zone blog:  [https://blogs.mathworks.com/developer](https://blogs.mathworks.com/developer/) 
-  CI licensing for private repositories:  [https://www.mathworks.com/support/batch\-tokens.html](https://www.mathworks.com/support/batch-tokens.html) 

Copyright 2026 The MathWorks, Inc.

