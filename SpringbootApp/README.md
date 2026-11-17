# Spring Blossom – Salesforce E‑Commerce Storefront

A full-featured **e-commerce application built natively on the Salesforce platform**, developed as a Salesforce DX project. Spring Blossom lets customers browse a product catalog, filter and search products, add items to a cart, check out with payment validation and live currency conversion, and track their orders — all powered by custom Apex, Lightning Web Components, Aura components, and record-triggered automation.

> **Tech at a glance:** Apex · Lightning Web Components (LWC) · Aura · Apex Triggers · SOQL (dynamic queries) · REST & SOAP APIs · HTTP Callouts · Experience Cloud (Communities) · Salesforce DX · Jest · ESLint/Prettier/Husky

---

## What the App Does

**For buyers (storefront experience):**
- Browse a product catalog with image carousels and detailed product pages
- Search and filter products by name, type, and max price, with server-side pagination
- Add products to a persistent cart tied to their buyer record
- Check out with credit-card validation and see cart totals converted to CAD/EUR in real time via an external currency-exchange API
- Self-register, log in, and recover passwords through Experience Cloud (community) pages
- View order history and order status after purchase

**Behind the scenes (automation):**
- New leads flagged as Spring Blossom customers are automatically converted into `Buyer__c` records, each buyer gets a cart created via trigger, and a community user is provisioned for them — zero manual steps
- Seller onboarding runs through an application-verification flow: once an application form is approved, a trigger auto-converts the lead (`Database.convertLead`), creates the `Seller__c` record, and provisions a seller user
- An invoice controller aggregates order line items (junction objects) with buyer and shipping details for order invoicing

---

## Skills Demonstrated

| Area | Where to look |
|---|---|
| **Apex development** | `force-app/main/default/classes` — 30+ classes incl. controllers, services, and test classes |
| **Dynamic SOQL + pagination** | `ProductController.cls` — builds a dynamic WHERE clause from user filters, returns a `PagedResult` with `LIMIT`/`OFFSET`, uses `@AuraEnabled(Cacheable=true)` for client-side caching |
| **Lightning Web Components** | `force-app/main/default/lwc` — `productTileList`, `productTile`, `productFilter`, `paginator`, `leadForm`, `contactList` with a `pubsub` module for cross-component communication |
| **Aura components & events** | `force-app/main/default/aura` — 25+ bundles: cart, checkout, payment, product carousel/detail/tabs, order tracking; component events (`AddToCart`, `OrderEvent`, `SelectedProduct`) wired across the storefront |
| **Apex triggers & bulkified handlers** | `BuyerRegistrationTrigger` (Lead → Buyer), `BuyerTrigger` (Buyer → Cart), `ApplicationFormTrigger` (verification → lead conversion), with logic kept in handler classes (`BuyerController`, `CartForBuyer`, `LeadAutoConvert`) |
| **Integrations – outbound** | `CurrencyCallouts.cls` — HTTP GET callout to a live currency-exchange API, JSON deserialization into typed maps |
| **Integrations – inbound** | `StudentInformationService.cls` — custom REST API (`@RestResource`, `@HttpGet`); `StudentSoapService.cls` — SOAP web service |
| **Apex testing** | Test classes incl. `CurrenciesCalloutsTest` with `HttpCalloutMock` for callout testing; standard controller test coverage |
| **Experience Cloud (Communities)** | Login, self-registration (incl. microbatch), forgot/change password controllers and Lightning components; programmatic community user provisioning from Apex |
| **Data modeling** | Custom objects incl. `Product__c`, `Product_Type__c`, `Buyer__c`, `Seller__c`, `Cart__c`, `Order__c`, with junction objects (`ProductCartJunction__c`, `OrderProductJunction__c`) for many-to-many cart and order lines |
| **Lead lifecycle** | Programmatic lead conversion with `Database.convertLead`, converted-status lookup, and downstream record/user creation |
| **DX & code quality tooling** | Salesforce DX project (API v61.0), scratch-org definition, `manifest/package.xml`, Jest config for LWC unit tests, ESLint, Prettier, Husky pre-commit hooks |

---

## Architecture

```
                        ┌──────────────────────────────────────────┐
                        │        Experience Cloud Storefront        │
                        │  (login / self-register / forgot pwd)     │
                        └───────────────────┬──────────────────────┘
                                            │
        ┌───────────────────────────────────┼───────────────────────────────────┐
        │                                   │                                   │
┌───────▼────────┐                 ┌────────▼────────┐                 ┌────────▼───────┐
│  LWC catalog   │                 │  Aura storefront │                 │  Aura checkout │
│  productTile*  │   pubsub /      │  carousel, search│  AddToCart /    │  cart, payment │
│  filter, pager │   component     │  detail, tabs    │  OrderEvent     │  currency conv │
└───────┬────────┘   events        └────────┬────────┘                 └────────┬───────┘
        │                                   │                                   │
        └───────────────────────────────────┼───────────────────────────────────┘
                                            │ @AuraEnabled
                              ┌─────────────▼──────────────┐
                              │        Apex services        │
                              │ ProductController (dyn SOQL)│
                              │ ProductSearch / Payment     │
                              │ CurrencyCallouts (HTTP) ────┼──► external FX-rate API
                              │ REST + SOAP endpoints ◄─────┼──  external consumers
                              └─────────────┬──────────────┘
                                            │ triggers
                              ┌─────────────▼──────────────┐
                              │      Data & automation      │
                              │ Lead ─► Buyer__c ─► Cart__c │
                              │ Product__c ⇄ Cart/Order via │
                              │ junction objects; Seller    │
                              │ onboarding via verification │
                              └────────────────────────────┘
```

---

## Project Structure

```
SpringbootApp/
├── force-app/main/default/
│   ├── aura/          # 25+ Aura bundles: storefront, cart, checkout, community auth
│   ├── lwc/           # LWC catalog components, paginator, pubsub, lead form
│   ├── classes/       # Apex controllers, services, REST/SOAP endpoints, tests
│   └── triggers/      # Buyer, cart, lead-conversion automation
├── config/            # Scratch-org definition
├── manifest/          # package.xml (API v61.0)
├── scripts/           # Sample SOQL / anonymous Apex
└── jest.config.js     # LWC unit-test setup (+ ESLint, Prettier, Husky)
```

---

## Getting Started

```bash
# Clone and open
git clone https://github.com/TruptiLone/salesforce-springboot-app.git
cd salesforce-springboot-app/SpringbootApp

# Authorize an org and deploy
sf org login web -a springblossom
sf project deploy start --manifest manifest/package.xml -o springblossom

# Or spin up a scratch org
sf org create scratch -f config/project-scratch-def.json -a springblossom-scratch
sf project deploy start -o springblossom-scratch
```

Requires the [Salesforce CLI](https://developer.salesforce.com/tools/salesforcecli). The storefront expects the custom objects and a community (Experience Cloud site) with Buyer/Seller profiles configured in the target org.

---

## About

Built by **Trupti Lone** — 4× Salesforce certified (Platform Developer I, Platform App Builder, Administrator, Sales Cloud Consultant) · Trailhead Ranger.

- LinkedIn: [linkedin.com/in/truptilone](https://www.linkedin.com/in/truptilone)
- GitHub: [@TruptiLone](https://github.com/TruptiLone)
