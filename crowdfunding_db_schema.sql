-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.



CREATE TABLE "campaigns" (
    "cf_id" SERIAL   NOT NULL,
    "campaign_id" SERIAL   NOT NULL,
    "category_id" INT   NOT NULL,
    "subcategory_id" INT   NOT NULL,
    "description" TEXT   NOT NULL,
    "goal" NUMERIC   NOT NULL,
    "pledged" NUMERIC   NOT NULL,
    "launch_date" DATE   NOT NULL,
    "end_date" DATE   NOT NULL,
    "FK" (category_id)   NOT NULL,
    CONSTRAINT "pk_campaigns" PRIMARY KEY (
        "campaign_id"
     )
);

CREATE TABLE "categories" (
    "category_id" SERIAL   NOT NULL,
    "category_name" VARCHAR(255)   NOT NULL,
    CONSTRAINT "pk_categories" PRIMARY KEY (
        "category_id"
     )
);

CREATE TABLE "subcategories" (
    "subcategory_id" SERIAL   NOT NULL,
    "subcategory_name" VARCHAR(255)   NOT NULL,
    "category_id" INT   NOT NULL,
    "FK" (category_id)   NOT NULL,
    CONSTRAINT "pk_subcategories" PRIMARY KEY (
        "subcategory_id"
     )
);


CREATE TABLE "contacts" (
    "contact_id" INT   NOT NULL,
    "name" VARCHAR(255)   NOT NULL,
    "email" VARCHAR(255)   NOT NULL,
    "campaign_id" INT   NOT NULL,
    "FK" (campaign_id)   NOT NULL,
    CONSTRAINT "pk_contacts" PRIMARY KEY (
        "contact_id"
     )
);

ALTER TABLE "subcategories" ADD CONSTRAINT "fk_subcategories_category_id" FOREIGN KEY("category_id")
REFERENCES "categories" ("category_id");

ALTER TABLE "campaigns" ADD CONSTRAINT "fk_campaigns_category_id" FOREIGN KEY("category_id")
REFERENCES "categories" ("category_id");

ALTER TABLE "campaigns" ADD CONSTRAINT "fk_campaigns_subcategory_id" FOREIGN KEY("subcategory_id")
REFERENCES "subcategories" ("subcategory_id");

ALTER TABLE "contacts" ADD CONSTRAINT "fk_contacts_contact_id" FOREIGN KEY("contact_id")
REFERENCES "campaigns" ("campaign_id");

