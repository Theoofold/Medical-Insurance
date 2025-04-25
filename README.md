# Medical-Insurance-Analysis

# Overview
This SQL-based project analyzes a health insurance dataset to uncover insights related to policyholder demographics, medical charges, BMI (Body Mass Index) patterns, and family-related trends. The analysis aids in understanding health cost drivers and behavior patterns among insured individuals. Using SQL, key metrics were derived to inform better pricing strategies and identify high-risk groups.
 
# Project Summary
Using SQL, I queried the dataset to analyze the following:
- Demographic breakdown
- BMI trends and classifications
- Medical charges and cost distribution
- Smoking impact on health costs
- Family size effects on charges
- Regional and gender-based patterns
- Smoker vs. non-smoker comparisons

# Key Insights
Demographics & Distribution
- Average policyholder age: 39 years
- Gender breakdown: Female: 662 | Male: 675
- Policyholders by region: Southwest: 325 | Southeast: 364 | Northwest: 324 | Northeast: 324
- Average BMI: Female: 30.38 | Male: 30.94
- Most common number of children: 0
  
Charges & Cost Analysis
- Average medical charge: $13,279.1
- Minimum charge: $1,121.9 | Maximum charge: $63,770.4
- Smoker charges: $32,050.2 | Non-smoker charges: $8,440.7
- Highest average regional cost: Southeast with an average charge of $14,735.4
- Charges by age group:
  18–19: $8,475.1 | 20–29: $9,561.8 | 30–39: $11,738.8
  40–49: $14,399.2 | 50–59: $16,495.2 | 60+: $21,248.00

BMI & Health Indicators
- Average BMI for smokers: 30.71 | Non-smokers: 30.65
- Most common BMI category: Overweight/Obese I
- Policyholders with BMI > 30: 704
- Charges:
  BMI > 30: $15,580.7 | BMI ≤ 30: $10,719.39
  
Family & Dependents
- Average charge among those with children: $13,949.9
- Most common number of children: 0
- Smokers tend to have more children on average
  
Combined Analysis
- Highest cost region for smokers: Southeast
- Highest charges: Male smokers
- Highest charge for non-smoker: $63,770.43
  
# Tools Used
- SQL
- MySQL Workbench (assumed environment)

# Business Questions Answered
- What is the demographic profile of policyholders?
- How does smoking affect charges and BMI?
- Which region incurs the highest average charges?
- What patterns emerge in charges by family size?
- How do age and BMI affect medical costs?

# Recommendations
1. Risk-Based Pricing:
   Implement differential pricing strategies based on smoking status and BMI, as these are major drivers of medical costs.

2. Targeted Health Campaigns:
   Focus wellness programs and health campaigns on smokers and individuals with BMI > 30 to reduce long-term insurance costs.

3. Regional Cost Optimization:
   Investigate the Southeast region for potential inefficiencies or high-risk profiles contributing to higher costs.

4. Encourage Preventive Care:
   Offer incentives for checkups and weight management to reduce the incidence of chronic conditions.
   
# Conclusion
This analysis highlights the strong correlation between health-related behaviors, especially smoking and BMI and medical charges. The Southeast region appears to be a cost-intensive area, potentially requiring closer review. By leveraging these insights, insurance providers can adopt more data-driven policies, promote healthier behaviors, and better manage risk across their client base.
