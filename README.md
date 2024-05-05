# Project 3
### Getting Started
- Before starting with this code, please install RMySQL and other packages that listed in the libraries at the beggining.
- Next, please make sure to make your DB instance global by running this command `mysql> set global local_infile=true;`.
- The framework here has successfully connected to my local instance db.
- We first will open the excel sheet as dataframe, then manipulate it by adding calculated fields.
- When we finished, the table should be written into MySQL db.

### Calculated Fields Meaning

- The Financial Impact Ratio (FIR) is a calculated metric that evaluates the proportion of laid-off employees relative to the financial resources available to the company. This could give stakeholders an idea of whether the company is leveraging its financial muscle to avoid layoffs or if financial resources do not influence layoff decisions.
- The Monthly Layoff Rate measures the average number of employees laid off each month. It is particularly useful for detecting immediate responses to market changes, economic downturns, or internal company events.
 This rate helps identify patterns or spikes in layoffs that could correlate with specific monthly business cycles or external economic events. For example, if a tech company releases its quarterly financial reports and layoffs spike in the following month, this could indicate cost-cutting measures in response to financial results.
- The Quarterly Layoff Rate extends the concept of the monthly rate to a three-month period.
This measure smooths out some of the volatility seen in monthly data, providing a broader view of layoff trends over each quarter. Quarterly data can be particularly insightful for observing the impacts of seasonal business fluctuations or the effects of strategic changes made at the executive level, which often align with quarterly reporting periods.
- The Employee Retention Rate is a critical metric in any organization, particularly in contexts involving layoffs. It measures the percentage of employees who remain in an organization over a given period, typically a year. In the case of analyzing data related to tech layoffs, understanding the Employee Retention Rate can provide several key insights:
- A high retention rate, even in the face of layoffs, can indicate that the remaining workforce feels secure and valued in their roles. It can also suggest effective communication and management strategies during the layoff process.
- If the layoffs are part of a restructuring strategy, observing retention rates can help gauge whether the strategy is effective or if it’s causing unintended consequences like high turnover among remaining employees.
