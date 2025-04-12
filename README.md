# <p align = 'center'>**Zoo Management System - ZMS**</p>
<p align ='center'> Developed by TeamDB - L10 - HK241</p> 

## Table of content
- [Introduction](#introduction)
- [Technologies Used](#technologies-used)
- [Source code](#source-code)
- [Data Requirements Description for the Zoo Management System](#data-requirements-description-for-the-zoo-management-system)
- [Semantic Constraints](#semantic-constraints)
- [Enhanced Entity-Relationship Diagram and Mapping](#enhanced-entity---relationship-diagram-eerd-and-mapping)
- [Database Schema Design in MySQL](#database-schema-design-in-mysql)
- [Source Code Structure](#source-code-structure)
- [Implementation](#implementation)
- [DEMO Features](#demo-features)
- [Installation Guide](#installation-guide)
- [Contributors](#contributors)

## **📌Introduction**
🦁 The Zoo Management System is a comprehensive application that supports the digital transformation of modern zoos. It provides powerful tools for managing animal species, individual animals, staff (including office workers, caretakers, and veterinarians), and diverse partner types such as food suppliers, research institutions, and other zoos. The system allows tracking of health records, vaccination history, treatment logs, and nutrition plans for both individual animals and groups. 

🦁 It also manages enclosures, feeding schedules, specimen records, and the logistics of animal import/export operations. With rich relational data handling, it ensures accurate monitoring of predator-prey relationships, breeding records, and parentage, supporting both operational and conservation needs.

<p align="center"><img src="assets/intro.png" alt="intro" width="800"></p>
<p align="center"><img src="assets/intro2.png" alt="intro2" width="800"></p>

## 🛠**Technologies Used**

- Frontend: `HTML, CSS, JS(ReactJS)` – Used to build a responsive and user-friendly web interface.

- Backend: `NestJS` – A progressive Node.js framework used to create a structured and scalable server-side application. It communicates with the database through stored procedures and functions.
- Database: `MySQL` – Relational database system used to store and manage zoo data, with business logic implemented through stored procedures and functions.

- API & Testing: `Postman` – A powerful API testing and debugging tool, streamlining API development and ensuring reliability through structured request-response testing.

- Version Control & Collaboration: `GitHub` – A cloud-based version control system facilitating seamless code management, collaboration, and deployment with features like branching, pull requests, and issue tracking.

- **Features**:
  - ✅ Authentication & Authorization
  - ✅ CRUD operations for zoo data (animals, health records, partners, etc.)

> ⚠️ You can create your own local database using the `Database.sql` file provided in the root directory.

<p align="center">
  <a href="http://nestjs.com/" target="blank"><img src="https://nestjs.com/img/logo-small.svg" width="120" alt="Nest Logo" /></a>
</p>

[circleci-image]: https://img.shields.io/circleci/build/github/nestjs/nest/master?token=abc123def456
[circleci-url]: https://circleci.com/gh/nestjs/nest

  <p align="center">A progressive <a href="http://nodejs.org" target="_blank">Node.js</a> framework for building efficient and scalable server-side applications.</p>
    <p align="center">
<a href="https://www.npmjs.com/~nestjscore" target="_blank"><img src="https://img.shields.io/npm/v/@nestjs/core.svg" alt="NPM Version" /></a>
<a href="https://www.npmjs.com/~nestjscore" target="_blank"><img src="https://img.shields.io/npm/l/@nestjs/core.svg" alt="Package License" /></a>
<a href="https://www.npmjs.com/~nestjscore" target="_blank"><img src="https://img.shields.io/npm/dm/@nestjs/common.svg" alt="NPM Downloads" /></a>
<a href="https://circleci.com/gh/nestjs/nest" target="_blank"><img src="https://img.shields.io/circleci/build/github/nestjs/nest/master" alt="CircleCI" /></a>
<a href="https://coveralls.io/github/nestjs/nest?branch=master" target="_blank"><img src="https://coveralls.io/repos/github/nestjs/nest/badge.svg?branch=master#9" alt="Coverage" /></a>
<a href="https://discord.gg/G7Qnnhy" target="_blank"><img src="https://img.shields.io/badge/discord-online-brightgreen.svg" alt="Discord"/></a>
<a href="https://opencollective.com/nest#backer" target="_blank"><img src="https://opencollective.com/nest/backers/badge.svg" alt="Backers on Open Collective" /></a>
<a href="https://opencollective.com/nest#sponsor" target="_blank"><img src="https://opencollective.com/nest/sponsors/badge.svg" alt="Sponsors on Open Collective" /></a>
  <a href="https://paypal.me/kamilmysliwiec" target="_blank"><img src="https://img.shields.io/badge/Donate-PayPal-ff3f59.svg" alt="Donate us"/></a>
    <a href="https://opencollective.com/nest#sponsor"  target="_blank"><img src="https://img.shields.io/badge/Support%20us-Open%20Collective-41B883.svg" alt="Support us"></a>
  <a href="https://twitter.com/nestframework" target="_blank"><img src="https://img.shields.io/twitter/follow/nestframework.svg?style=social&label=Follow" alt="Follow us on Twitter"></a>
</p>
  <!--[![Backers on Open Collective](https://opencollective.com/nest/backers/badge.svg)](https://opencollective.com/nest#backer)
  [![Sponsors on Open Collective](https://opencollective.com/nest/sponsors/badge.svg)](https://opencollective.com/nest#sponsor)-->


## 🚀**Source code:**
The source code of the software can be accessed via the following link:

🔗 [Source code backend](https://github.com/tuitensonne/Zoo-backend)

🔗 [Source code frontend](https://github.com/tuitensonne/Zoo-frontend)

🔗 [UI/UX Design (Figma)](https://www.figma.com/design/ublOB0fGMaNA7qOHDUZynx/Untitled?node-id=0-1&t=DKyjMi1vJae1QkcB-1)

## 📌**Data Requirements Description for the Zoo Management System** 
### 🚀 **Staff – Office Staff – Caretakers – Veterinarians**:

The system needs to manage information about employees related to animals, including office staff, caretakers, and veterinarians. Each staff member has general information including:
- Citizen ID number (CCCD) (unique)
- Full name
- Address
- Job type
- Phone number(s) (one staff may have multiple)

Additional requirements based on role:
- `Office Staff`: must include information about qualifications
- `Caretakers`: must have an animal care certificate
- `Veterinarians`: must have a practicing license and years of experience

### 🚀 **Partners – Research Institutes – Zoos – Food Suppliers**:

The system must manage information about zoo partners, including food suppliers, educational institutions, zoos, and research institutes. Each partner includes:
- Partner ID (ID_DT) (unique)
- Name
- Contact info: email, address, and phone numbers (can be multiple)

Additional requirements:
- `Food Suppliers`: Must include food safety certifications (can be multiple). Ordering limits per food type (e.g., 50kg)
- `Zoos`: Type of zoo (public, private, non-profit). Conservation programs (e.g., species conservation, gene conservation)
- `Research Institutes`: Must include research fields

### 🚀 **Animal Species – Group – Individual – Enclosure – Specimen**:

Each animal species must have:
- Scientific name (unique)
- Common name
- Rarity level
- Type of food
- Reproduction cycle: cycle duration & gestation period
- Natural habitat
- Predator-prey relationships

- Animals can be tracked as `groups` or `individuals`:
  - Group:
    - Linked to species
    - Requires: Group ID (ID_N) and quantity
    - The combination of ID_N + species’ scientific name is unique
  - Individual:
    - Requires: ID_CT, DNA, gender, status, age
    - May include father and mother references

- Enclosure:
  - Enclosure ID (ID_KV) (unique)
  - Dimensions: area, height
  - Habitat type
  - Location
  - Maximum capacity
  - Activity status
  - Current quantity of animals (individuals + groups)
- Specimen:
  - Specimen ID (ID_MV)
  - Species
  - Specimen name
  - Condition
  - Collection date
 
### 🚀 **Nutrition Plan – Health Record – Treatment History – Vaccination History – Meal**:
- Nutrition Plan:
  - ID_CDDD (linked to health record)
  - Required water amount
  - Number of meals/day
  - Restricted foods
  - Minimum nutritional values
- Health Record:
  - ID_HSSK
  - Health status, height, weight
- Treatment History:
  - ID_DT, symptoms, medications, diagnosis, treatment outcome, notes, treatment date
- Vaccination History:
  - ID_TC, vaccine type, dosage, post-vaccine reaction, date, method of administration
- Meal:
  - Meal name, feeding time, species, and feeding date

### 🚀 **Import Forms – Animal Import – Food Import – Food – Animal Export**:
- Import Forms:
  - ID_PN, import date, quantity
  - Two types:
    - `Food Import`: requires origin/source
    - `Animal Import`: requires import reason
- Animal Export Forms:
  - ID_PX, export date, description (including quantity and reason)
- Food Item:
  - ID_TA, total quantity, name, nutritional content, expiration date

### 🚀 **Relationships**:

- Species–Predator-Prey:
  - A species can have multiple predators, and predators can hunt multiple prey
- Animal–Enclosure:
  - Each group/individual must reside in one `enclosure`
  - Each enclosure may contain multiple groups/individuals
- Animal–Health Record:
  - Each group/individual must have one health record
  - A health record can be linked to:
    - Multiple `nutrition plans`
    - Multiple `treatment histories`
    - Multiple `vaccination histories`
- Veterinarian Involvement:
  - Each health record must be modified by one veterinarian
  - Each veterinarian can modify multiple health records
  - Each nutrition plan is adjusted by one veterinarian
  - Each nutrition plan can be linked to multiple meals
- Caretaker Roles:
  - Performs meals for multiple enclosures
  - Each enclosure is cared for based on one meal at a specific time by one caretaker
  - A caretaker may serve multiple meals for the same enclosure at different times
  - Feeding date must be recorded
- Office Staff & Forms:
  - One office staff may create multiple: `Import forms`, `Animal export forms`
- Food Import – Supplier:
  - Each food import form is linked to one food supplier
  - One supplier may have multiple food import forms
- Food Item Usage:
  - A food item may appear in multiple food import forms
  - A meal may contain multiple food items
  - Must record quantity used per meal
- Animal Import/Export – Zoo Partners:
  - Each form is associated with one zoo
  - Each zoo partner may be involved in multiple imports/exports
- Animal Rental:
  - Individual animals may be rented out to other zoos
  - Each zoo may rent multiple individual animals
- Specimen Ownership:
  - Each `individual` may have multiple `specimens`
  - Each `specimen` belongs to one `individual`
  - `Research institutes` store specimens (one specimen belongs to one institute)
- Animal Lineage:
  - Each individual must have one father and one mother
  - One individual can be a parent of many others
- Group & Individual:
  - Animals may be in groups or individuals
  - A species might have no groups/individuals if population = 0
- Species Relations:
  - Each species:
    - Has multiple `groups`
    - Has multiple `individuals`
    - May be involved in `multiple import/export forms`
## 📌**Semantic Constraints** 
## 📌**Enhanced Entity-Relationship Diagram EERD and Mapping**
## 📌**Database Schema Design in MySQL** 
## 📌**Procedure, Trigger, and Function** 
## 📌**Source Code Structure** 
## 📌**Implementation**
## 📌**DEMO Features**

<p align="center"><img src="assets/demo1.png" alt="table" width="600"></p>
<p align="center"><img src="assets/demo2.png" alt="table" width="600"></p>
<p align="center"><img src="assets/demo3.png" alt="table" width="600"></p>
<p align="center"><img src="assets/demo4.png" alt="table" width="600"></p>
<p align="center"><img src="assets/demo5.png" alt="table" width="600"></p>
<p align="center"><img src="assets/demo6.png" alt="table" width="600"></p>
<p align="center"><img src="assets/demo7.png" alt="table" width="600"></p>
<p align="center"><img src="assets/demo8.png" alt="table" width="600"></p>
<p align="center"><img src="assets/demo9.png" alt="table" width="600"></p>
<p align="center"><img src="assets/demo10.png" alt="table" width="600"></p>
<p align="center"><img src="assets/demo11.png" alt="table" width="600"></p>
<p align="center"><img src="assets/demo12.png" alt="table" width="600"></p>
<p align="center"><img src="assets/demo13.png" alt="table" width="600"></p>
<p align="center"><img src="assets/demo14.png" alt="table" width="600"></p>
<p align="center"><img src="assets/demo15.png" alt="table" width="600"></p>
<p align="center"><img src="assets/demo16.png" alt="table" width="600"></p>


## 📌**Installation Guide**
### Project setup

```bash
$ npm install
```

### Compile and run the project

```bash
# development
$ npm run start

# watch mode
$ npm run start:dev

# production mode
$ npm run start:prod
```

## 🏆Contributors
This project was successfully developed thanks to the dedication and effort of the following contributors:
1. Trần Nam Sơn - 2212956
2. Nguyễn Quang Sáng - 2212922
3. Trần Quang Tác - 2212962

🎉🎉🎉 Thank you for checking out this project! 🚀



