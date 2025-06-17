CREATE DATABASE VirtualArtGallery
use VirtualArtGallery


CREATE TABLE Artists (
 ArtistID INT PRIMARY KEY,
 Name VARCHAR(255) NOT NULL,
 Biography TEXT,
 Nationality VARCHAR(100));

 CREATE TABLE Categories (
 CategoryID INT PRIMARY KEY,
 Name VARCHAR(100) NOT NULL);

 CREATE TABLE Artworks (
 ArtworkID INT PRIMARY KEY,
 Title VARCHAR(255) NOT NULL,
 ArtistID INT,
 CategoryID INT,
 Year INT,
 Description TEXT,
 ImageURL VARCHAR(255),
 FOREIGN KEY (ArtistID) REFERENCES Artists (ArtistID),
 FOREIGN KEY (CategoryID) REFERENCES Categories (CategoryID));

 CREATE TABLE Exhibitions (
 ExhibitionID INT PRIMARY KEY,
 Title VARCHAR(255) NOT NULL,
 StartDate DATE,
 EndDate DATE,
 Description TEXT);

 CREATE TABLE ExhibitionArtworks (
 ExhibitionID INT,
 ArtworkID INT,
 PRIMARY KEY (ExhibitionID, ArtworkID),
 FOREIGN KEY (ExhibitionID) REFERENCES Exhibitions (ExhibitionID),
 FOREIGN KEY (ArtworkID) REFERENCES Artworks (ArtworkID))

 INSERT INTO Artists (ArtistID, Name, Biography, Nationality) VALUES
(1, 'Vincent van Gogh', 'Dutch post-impressionist painter', 'Dutch'),
(2, 'Leonardo da Vinci', 'Italian polymath of the Renaissance', 'Italian'),
(3, 'Pablo Picasso', 'Spanish painter and sculptor', 'Spanish'),
(4, 'Frida Kahlo', 'Mexican painter known for self-portraits', 'Mexican'),
(5, 'Salvador Dalí', 'Spanish surrealist artist', 'Spanish');

INSERT INTO Categories (CategoryID, Name) VALUES
(1, 'Painting'),
(2, 'Sculpture'),
(3, 'Drawing'),
(4, 'Modern Art'),
(5, 'Classic Art');

INSERT INTO Artworks (ArtworkID, Title, ArtistID, CategoryID, Year, Description, ImageURL) VALUES
(1, 'Starry Night', 1, 1, 1889, 'Famous night sky painting', 'url1'),
(2, 'Mona Lisa', 2, 1, 1503, 'Famous portrait', 'url2'),
(3, 'Guernica', 3, 4, 1937, 'Anti-war painting', 'url3'),
(4, 'The Persistence of Memory', 5, 4, 1931, 'Melting clocks', 'url4'),
(5, 'Self Portrait', 4, 1, 1940, 'Self portrait of Frida Kahlo', 'url5'),
(6, 'The Weeping Woman', 3, 1, 1937, 'Emotional artwork', 'url6'),
(7, 'Vitruvian Man', 2, 3, 1490, 'Proportions of human body', 'url7'),
(8, 'The Last Supper', 2, 5, 1498, 'Biblical scene', 'url8'),
(9, 'Sunflowers', 1, 1, 1888, 'Still life with sunflowers', 'url9'),
(10, 'The Elephants', 5, 2, 1948, 'Elephants with long legs', 'url10'),
(11, 'The Dream', 3, 4, 1932, 'Cubist painting', 'url11'),
(12, 'Untitled Work', 4, 2, 1945, 'Sculpture by Kahlo', 'url12'),
(13, 'Irises', 1, 1, 1889, 'Flower painting', 'url13');

INSERT INTO Artworks (ArtworkID, Title, ArtistID, CategoryID, Year, Description, ImageURL) VALUES
(14, 'Bedroom in Arles', 1, 1, 1888, 'van Gogh bedroom painting', 'url14');

INSERT INTO Artworks (ArtworkID, Title, ArtistID, CategoryID, Year, Description, ImageURL)
VALUES (15, 'Sculpted Starry', 1, 2, 1890, 'A rare sculpture by van Gogh', 'url15');


INSERT INTO Artworks (ArtworkID, Title, ArtistID, CategoryID, Year, Description, ImageURL)
VALUES (16, 'Pencil Sketch', 1, 3, 1887, 'A drawing by van Gogh', 'url16');


INSERT INTO Artworks (ArtworkID, Title, ArtistID, CategoryID, Year, Description, ImageURL)
VALUES (17, 'Modern Swirls', 1, 4, 1891, 'Experimental modern art', 'url17');


INSERT INTO Artworks (ArtworkID, Title, ArtistID, CategoryID, Year, Description, ImageURL)
VALUES (18, 'Classic Horizon', 1, 5, 1892, 'A classic piece by van Gogh', 'url18');

INSERT INTO Exhibitions (ExhibitionID, Title, StartDate, EndDate, Description) VALUES
(1, 'Modern Art Masterpieces', '2022-01-01', '2022-06-30', 'A showcase of modern art.'),
(2, 'Renaissance Art', '2023-03-01', '2023-08-01', 'Classic Renaissance artworks.'),
(3, 'Surrealism Wonders', '2022-07-01', '2022-12-31', 'Surrealist artworks collection.');


INSERT INTO ExhibitionArtworks (ExhibitionID, ArtworkID) VALUES
-- Modern Art Masterpieces
(1, 1), -- Starry Night
(1, 3), -- Guernica
(1, 4), -- Persistence of Memory
(1, 6), -- The Weeping Woman
(1, 11), -- The Dream

-- Renaissance Art
(2, 2), -- Mona Lisa
(2, 7), -- Vitruvian Man
(2, 8), -- The Last Supper

-- Surrealism Wonders
(3, 4), -- Persistence of Memory
(3, 10); -- The Elephants

INSERT INTO ExhibitionArtworks (ExhibitionID, ArtworkID) VALUES
(2, 1), -- Starry Night also in Renaissance Art
(2, 3); -- Guernica also in Renaissance Art

-- QUERY 1:
SELECT A.Name,COUNT(ARW.ArtworkID) AS ARTWORK_COUNT
FROM ARTISTS AS A LEFT JOIN Artworks ARW ON A.ArtistID=ARW.ArtistID 
GROUP BY A.Name ORDER BY ARTWORK_COUNT DESC;

/*QUERY 2: List the titles of artworks created by artists from 'Spanish' and 'Dutch' nationalities, and order
them by the year in ascending order.*/
SELECT * from Artworks;
SELECT * FROM Artists;
SELECT ARW.TITLE,ARW.YEAR,A.Nationality from Artworks ARW 
JOIN Artists A ON ARW.ArtistID=A.ArtistID 
WHERE A.Nationality IN ('spanish','dutch') ORDER BY ARW.Year asc;

/*QUERY 3: Find the names of all artists who have artworks in the 'Painting' category, and the number of
artworks they have in this category.*/
SELECT * from Artworks;
SELECT * from Artists;
SELECT A.Name,COUNT(*) AS ARTWORK_COUNT,C.Name AS Category_Name FROM Artists A 
JOIN Artworks ARW ON A.ArtistID=ARW.ArtistID 
JOIN Categories C ON C.CategoryID=ARW.CategoryID WHERE C.NAME='Painting' GROUP BY A.Name,C.Name;

/*QUERY 4: List the names of artworks from the 'Modern Art Masterpieces' exhibition, along with their
artists and categories.*/
SELECT * from Artworks;
SELECT * FROM Exhibitions;
SELECT * from ExhibitionArtworks;
Select ARW.Title AS Artwork_Title,E.Title AS Exhibition_Title,A.Name AS Artist_Name,C.Name AS Category_Name FROM Artworks ARW
JOIN Artists A ON ARW.ArtistID=A.ArtistID
JOIN Categories C ON C.CategoryID=ARW.CategoryID
JOIN ExhibitionArtworks EA ON ARW.ArtworkID=EA.ArtworkID
JOIN Exhibitions E ON E.ExhibitionID=EA.ExhibitionID
WHERE E.Title='Modern Art Masterpieces'

--QUERY 5: Find the artists who have more than two artworks in the gallery
SELECT * from Artists
SELECT * from Artworks
SELECT A.Name,COUNT(*) AS Artwork_count FROM Artists A INNER JOIN Artworks ARW 
ON A.ArtistID=ARW.ArtistID 
GROUP BY A.Name
HAVING COUNT(*)>2

/*QUERY 6: Find the titles of artworks that were exhibited in both 'Modern Art Masterpieces' and
'Renaissance Art' exhibitions.*/
SELECT * from Artworks;
SELECT * FROM ExhibitionArtworks
SELECT ARW.Title
FROM Artworks ARW
JOIN ExhibitionArtworks EA ON ARW.ArtworkID = EA.ArtworkID
JOIN Exhibitions E ON EA.ExhibitionID = E.ExhibitionID
WHERE E.Title IN ('Modern Art Masterpieces', 'Renaissance Art')
GROUP BY ARW.Title
HAVING COUNT(DISTINCT E.Title) = 2;

/*QUERY 7: Find the total number of artworks in each category*/
SELECT * from Artworks;
SELECT * FROM Categories
SELECT C.Name,COUNT(ARW.ArtworkID) AS Artwork_Count FROM Categories C
JOIN Artworks ARW ON C.CategoryID=ARW.CategoryID
GROUP BY C.Name

/*QUERY 8: List artists who have more than 3 artworks in the gallery.*/
SELECT * from Artworks;
SELECT * FROM Categories
SELECT A.Name ,COUNT(ARW.ArtworkID) AS Artwork_count FROM Artists A
JOIN Artworks ARW ON A.ArtistID=ARW.ArtistID
GROUP BY A.Name
HAVING COUNT(ARW.ArtworkID)>3

/*QUERY 9: Find the artworks created by artists from a specific nationality (e.g., Spanish).*/
SELECT * from Artworks;
SELECT * FROM Artists
SELECT ARW.Title,A.Name,A.Nationality FROM Artworks ARW 
JOIN Artists A ON ARW.ArtistID=A.ArtistID
WHERE A.Nationality='Spanish'

/*QUERY 10:List exhibitions that feature artwork by both Vincent van Gogh and Leonardo da Vinci.*/
SELECT * from Artworks;
SELECT E.Title
FROM Exhibitions E
JOIN ExhibitionArtworks EA ON E.ExhibitionID = EA.ExhibitionID
JOIN Artworks ARW ON EA.ArtworkID = ARW.ArtworkID
JOIN Artists A ON ARW.ArtistID = A.ArtistID
WHERE A.Name IN ('Vincent van Gogh', 'Leonardo da Vinci')
GROUP BY E.Title
HAVING COUNT(DISTINCT A.Name) = 2;

/*QUERY 11. Find all the artworks that have not been included in any exhibition*/
SELECT * from Artworks;
SELECT * FROM ExhibitionArtworks
SELECT ARW.Title
FROM Artworks ARW
LEFT JOIN ExhibitionArtworks EA ON ARW.ArtworkID = EA.ArtworkID
WHERE EA.ExhibitionID IS NULL;

/*QUERY 12. List artists who have created artworks in all available categories*/
SELECT * from Artworks;
SELECT * FROM Categories
SELECT A.Name
FROM Artists A
JOIN Artworks ARW ON A.ArtistID = ARW.ArtistID
GROUP BY A.ArtistID, A.Name
HAVING COUNT(DISTINCT ARW.CategoryID) = (
    SELECT COUNT(*) FROM Categories
);

/*QUERY 13. List the total number of artworks in each category.*/
SELECT * from Artworks;
SELECT * FROM Categories
SELECT C.Name,COUNT(*)AS ARTWORK_COUNT FROM Categories C
JOIN Artworks ARW ON C.CategoryID=ARW.CategoryID
GROUP BY C.Name;

/*QUERY 14. Find the artists who have more than 2 artworks in the gallery.*/
SELECT * from Artworks;
SELECT * FROM Categories
SELECT A.Name,COUNT(*) AS ARTWORK_COUNT FROM Artists A
JOIN Artworks ARW ON A.ArtistID=ARW.ArtistID
GROUP BY A.NAME
HAVING COUNT(*)>2

/*QUERY 15: List the categories with the average year of artworks they contain, only for categories with more
than 1 artwork.*/
SELECT * from Artworks;
SELECT * FROM Categories
SELECT  C.Name AS Category_Name, AVG(ARW.Year) AS Average_Year, COUNT(*) AS Artwork_Count
FROM Categories C
JOIN Artworks ARW ON C.CategoryID = ARW.CategoryID
GROUP BY C.Name
HAVING COUNT(*) > 1;

/*QUERY 16: Find the artworks that were exhibited in the 'Modern Art Masterpieces' exhibition.*/
SELECT * from Artworks;
SELECT * FROM Exhibitions
SELECT * FROM ExhibitionArtworks
SELECT ARW.Title FROM Artworks ARW 
JOIN ExhibitionArtworks EA ON EA.ArtworkID=ARW.ArtworkID
JOIN Exhibitions E ON E.ExhibitionID=EA.ExhibitionID
WHERE E.Title='Modern Art Masterpieces'

/*QUERY 17:Find the categories where the average year of artworks is greater than the average year of all
artworks.*/
SELECT * from Artworks;
SELECT * FROM Exhibitions
SELECT C.Name AS Category_Name,AVG(ARW.Year) AS Avg_Year
FROM Categories C JOIN Artworks ARW ON C.CategoryID = ARW.CategoryID
GROUP BY C.Name
HAVING AVG(ARW.Year) > (SELECT AVG(Year) FROM Artworks);

/*QUERY 18:List the artworks that were not exhibited in any exhibition.
(SAME AS QUERY 11?)*/
SELECT * from Artworks;
SELECT * FROM ExhibitionArtworks
SELECT ARW.Title
FROM Artworks ARW
LEFT JOIN ExhibitionArtworks EA ON ARW.ArtworkID = EA.ArtworkID
WHERE EA.ExhibitionID IS NULL;

/*QUERY 19: Show artists who have artworks in the same category as "Mona Lisa.)*/
SELECT * from Artworks;
SELECT DISTINCT A.Name FROM Artworks AW
JOIN Artists A ON A.ArtistID = AW.ArtistID
WHERE AW.CategoryID = (SELECT CategoryID FROM Artworks WHERE Title = 'Mona Lisa'
);

/*QUERY 19:List the names of artists and the number of artworks they have in the gallery.*/
SELECT * from Artworks;
SELECT * from Artists
SELECT A.Name,COUNT(*) FROM Artworks AW
JOIN Artists A ON A.ArtistID = AW.ArtistID
GROUP BY A.Name


