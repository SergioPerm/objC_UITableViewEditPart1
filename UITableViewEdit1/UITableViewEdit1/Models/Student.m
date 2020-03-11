//
//  Student.m
//  UITableViewEdit1
//
//  Created by kluv on 11/03/2020.
//  Copyright © 2020 com.kluv.hw24. All rights reserved.
//

#import "Student.h"

@implementation Student

static NSString* firstNames[] = {
    @"Kaye",@"Chava",@"Teegan",@"Sean",@"Ryan",@"Priscilla",@"Baxter",@"Thane",@"Zephania",@"Heather",@"Elliott",@"Lamar",@"Samuel",@"Jolene",@"Coby",@"Jordan",@"Minerva",@"Velma",@"Ishmael",@"Illiana",@"Kyle",@"Cooper",@"Madaline",@"Meredith",@"Dominique",@"Willow",@"Yasir",@"Hakeem",@"Chaim",@"Candace",@"Mia",@"Brandon",@"Harrison",@"Uriah",@"Joy",@"Ruth",@"Rashad",@"Megan",@"Fatima",@"Mikayla",@"Keegan",@"Uriel",@"Herman",@"Stewart",@"Roth",@"Lance",@"Nathan",@"Jolene",@"Iris",@"Damian",@"Michelle",@"Colleen",@"Nissim",@"Dominic",@"Rashad",@"Willow",@"Ciara",@"Buffy",@"Dai",@"Indigo",@"Hayden",@"Azalia",@"Cassidy",@"Porter",@"Seth",@"Inez",@"Hammett",@"Curran",@"Lamar",@"Casey",@"McKenzie",@"Juliet",@"Sonia",@"Mark",@"Dane",@"Meredith",@"Merrill",@"Brock",@"Ulric",@"Isaiah",@"Judah",@"Giacomo",@"Ivor",@"Kieran",@"Judah",@"Carly",@"Lynn",@"Prescott",@"Hedda",@"Linus",@"Marcia",@"Gavin",@"Sydney",@"Yuri",@"Leroy",@"Macaulay",@"Mari",@"Dalton",@"Ulla",@"Guy"
    
};

static NSString* lastNames[] = {
    @"Ingram",@"Dillard",@"Ashley",@"Bell",@"Becker",@"Cervantes",@"Knowles",@"Dickerson",@"Davenport",@"Weiss",@"Harmon",@"Michael",@"Ware",@"Tucker",@"Hubbard",@"Santos",@"Payne",@"Ingram",@"Oneill",@"Baker",@"Cooke",@"Dejesus",@"Bell",@"Puckett",@"Burris",@"Dillard",@"Bullock",@"Terrell",@"Shaffer",@"Wilder",@"Maxwell",@"Rollins",@"Maxwell",@"Lloyd",@"Vaughan",@"Erickson",@"Cohen",@"Johnston",@"Wolfe",@"Mckenzie",@"Faulkner",@"Edwards",@"Morgan",@"Burris",@"Farmer",@"Peters",@"Potter",@"Townsend",@"Cruz",@"Ramirez",@"Sims",@"Patterson",@"French",@"Warner",@"Cooke",@"Cantu",@"Walker",@"Wynn",@"Goodman",@"Carney",@"Osborn",@"Clemons",@"Spence",@"Vance",@"Sargent",@"Bonner",@"Nelson",@"Gutierrez",@"Ellison",@"Sanford",@"Terrell",@"Herrera",@"Massey",@"Barry",@"Logan",@"Mathis",@"Nolan",@"Schultz",@"Buckley",@"Buchanan",@"Valentine",@"Luna",@"Santos",@"Bradford",@"Robertson",@"Gilmore",@"Cline",@"Weeks",@"Melendez",@"Giles",@"Burton",@"Mcguire",@"Brady",@"Sparks",@"Terry",@"Fields",@"Potter",@"Holman",@"Wyatt",@"Lambert"
    
};

static int namesCount = 100;

+ (Student*) randomStudent {
    
    Student* student = [[Student alloc] init];
    
    student.firstName = firstNames[arc4random() % namesCount];
    student.lastName = lastNames[arc4random() % namesCount];
    
    student.averageGrade = ((CGFloat)((arc4random() % 301) + 200)) / 100;
    
    return student;
    
}

@end
