<a name="readme-top"></a>

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![LinkedIn][linkedin-shield]][linkedin-url]


<br />
<div align="center">
  <h3 align="center">Tea Subscription Service</h3>

  <p align="center">
  Turing School of Software & Design - Mod 4 - Final Take Home Project
  <br />
  <a href="https://mod4.turing.edu/projects/take_home/"><strong>Turing docs</strong></a>
  </p>
</div>

<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li>
    <a href="#project-description">About The Project</a>
    <ul>
      <li><a href="#learning-goals">Learning Goals</a></li>
      <li><a href="#versions">Versions</a></li>
      <li><a href="#important-gems">Important Gems</a></li>
      <li><a href="#database-schema">Database Schema</a></li>
    </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#repo-set-up">Repo Set Up</a></li>
        <li><a href="#use-of-this-repository">Use of Repo</a></li>
          <ul>
            <li>Backend Server</li>
          </ul>
      </ul>
    </li>
    <li>
      <a href="#api">Tea Sub Service</a>
      <details>
        <summary>Available Endpoints</summary>
        <ul>
          <li><a href="#subscribe-endpoint">Subscribe Endpoint</a></a></li>
          <li><a href="#cancel-subscription-endpoint">Cancel Subscription Endpoint</a></a></li>
          <li><a href="#all-subscriptions-endpoint">All Subscriptions Endpoint</a></a></li>
        </ul>
      </details>
    </li>
  </ol>
</details>

----------

## Project Description

The take-home project was meant to simulate a task that I might receive during an interview process. The purpose to prepare students for real world hiring situations. This simulation had us creating a basic subscription service back end api. We were asked to create three endpoints for the service.

## Learning Goals:

- Simulate real world hiring process
- Complete project within time constraints
- Display understanding of Rails
- Display ability to create restful routes

<p align="right">(<a href="#readme-top">back to top</a>)</p>

----------

### Versions

- 'Ruby 3.1.1'
- 'Rails 7.0.5'

<p align="right">(<a href="#readme-top">back to top</a>)</p>

----------

### Important Gems

- Testing:
![Pry][Pry-img]
![RSPEC][RSPEC-img]
![Shoulda Matchers][Shoulda Matchers-img]
![Simplecov][Simplecov-img]

- API: [jsonapi-serializer](https://github.com/fotinakis/jsonapi-serializers)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

----------

## Database Schema
```
 create_table "customers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subscriptions", force: :cascade do |t|
    t.string "title"
    t.integer "status", default: 0
    t.integer "frequency"
    t.float "price"
    t.bigint "customer_id", null: false
    t.bigint "tea_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_subscriptions_on_customer_id"
    t.index ["tea_id"], name: "index_subscriptions_on_tea_id"
  end

  create_table "teas", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.float "temperature"
    t.integer "brew_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

----------

## Getting Started

### Repo Set Up
On your local system, open a terminal session and run the following:
1. Clone this repo `$ git clone git@github.com:ithill22/tea_sub_service.git`
2. Navigate into your new repo `$ cd tea_sub_service`
3. Run `$ bundle install` to install the requiored gems
4. Set up the database locally with `$ rails db:{create,migrate}`
5. Open your text editor to make sure the new `schema.rb` exists
8. Run the RSpec test suite locally with the command `$ bundle exec rspec` to ensure everything is functioning correctly

### Use of this Repository

**Backend Server**

On you command line:
1. Navigate to the local directory where the backend repo is hoursed
2. Run `$ rails server` to the run the server locally
3. Open a web browser and navigate to http://localhost:3000/
4. Here you able able to explore the endpoints exposed by the API

<p align="right">(<a href="#readme-top">back to top</a>)</p>

----------

## API
Available endpoints

### Subscribe endpoint

| http verb | name | params | description | example |
| --- | --- | --- | --- | --- |
| POST | /customers/<customer_id>/subscriptions | title, price, frequency, tea id | Add tea subscription to existing customer | /api/v0/customers/1/subscriptions |


<details>
  <summary> JSON response examples </summary>


Customer Subscription Request:
  ```
  {
    "title": "Earl Grey",
    "price": "10.00",
    "frequency": "1",
    "tea_id": "1"
  }
  ```
Created Subscription response:
  ```
  {
    "data":{
      "id": "1",
      "type": "subscriptions",
      "attributes": {
        "title": "Earl Grey",
        "price": "10.00",
        "frequency": "biweekly",
        "tea_id": "1",
        "status": "active"
      }
    }
  }
  ```

</details>

### Cancel Subscription endpoint

| http verb | name | description | example |
| --- | --- | --- | --- |
| DELETE | /customers/<customer_id>/subscriptions | Changes the status of a subscription to "cancelled" | /api/v0/customers/1/subscriptions |

<details>
  <summary> JSON response example </summary>

Cancelled Subscription response:
  ```
  {
    "data":{
      "id": "1",
      "type": "subscriptions",
      "attributes": {
        "title": "Earl Grey",
        "price": "10.00",
        "frequency": "biweekly",
        "tea_id": "1",
        "status": "cancelled"
      }
    }
  }
  ```

</details>

### All Subscriptions endpoint

| http verb | name | description | example |
| --- | --- | --- | --- |
| GET | /customers/<customer_id>/subscriptions | Retrieve a list of all customer subscriptions | /api/v0/customers/1/subscriptions |

<details>
  <summary> JSON response example </summary>

All Subscriptions response:
  ```
{
  "data": [
    {
      "id": "1",
      "type": "subscriptions",
      "attributes": {
        "title": "Earl Grey",
        "price": "10.00",
        "frequency": "biweekly",
        "tea_id": "1",
        "status": "cancelled"
      }
    },
    {
      "id": "2",
      "type": "subscriptions",
      "attributes": {
        "title": "Green Tea",
        "price": "8.00",
        "frequency": "monthly",
        "tea_id": "2",
        "status": "active"
      }
    },
    {
      "id": "3",
      "type": "subscriptions",
      "attributes": {
        "title": "Chamomile",
        "price": "12.00",
        "frequency": "weekly",
        "tea_id": "3",
        "status": "active"
      }
    }
  ]
}
  ```

</details>



<p align="right">(<a href="#readme-top">back to top</a>)</p>

----------

### License

Distributed under the MIT License.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

----------

### Contact

Isaac Thill - [LinkedIn](https://www.linkedin.com/in/isaac-thill/)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- MARKDOWN LINK & IMAGES -->
[contributors-shield]: https://img.shields.io/github/contributors/ithill22/tea_sub_service.svg?style=for-the-badge
[contributors-url]: https://github.com/ithill22/tea_sub_service/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/ithill22/tea_sub_service.svg?style=for-the-badge
[forks-url]: https://github.com/ithill22/tea_sub_service/network/members
[stars-shield]: https://img.shields.io/github/stars/ithill22/tea_sub_service.svg?style=for-the-badge
[stars-url]: https://github.com/ithill22/tea_sub_service/stargazers
[issues-shield]: https://img.shields.io/github/issues/ithill22/tea_sub_service.svg?style=for-the-badge
[issues-url]: https://github.com/ithill22/tea_sub_service/issues
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://www.linkedin.com/in/isaac-thill/
[Pry-img]: https://img.shields.io/badge/pry-b81818.svg?&style=flaste&logo=rubygems&logoColor=white
[RSPEC-img]: https://img.shields.io/badge/rspec-b81818.svg?&style=flaste&logo=rubygems&logoColor=white
[Shoulda Matchers-img]: https://img.shields.io/badge/shoulda--matchers-b81818.svg?&style=flaste&logo=rubygems&logoColor=white
[Simplecov-img]: https://img.shields.io/badge/simplecov-b81818.svg?&style=flaste&logo=rubygems&logoColor=white
[VCR-img]: https://img.shields.io/badge/vcr-b81818.svg?&style=flaste&logo=rubygems&logoColor=white
