CREATE DATABASE IF NOT EXISTS movie_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE movie_db;

-- =============================================
-- TABLES
-- =============================================

CREATE TABLE category (
                          id INT AUTO_INCREMENT PRIMARY KEY,
                          name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE movie (
                       id INT AUTO_INCREMENT PRIMARY KEY,
                       title VARCHAR(200) NOT NULL,
                       description TEXT,
                       duration_minutes INT,
                       rating DECIMAL(3,1) CHECK (rating BETWEEN 0 AND 10),
                       release_year INT,
                       release_month INT CHECK (release_month BETWEEN 1 AND 12),
                       image_url VARCHAR(500),
                       category_id INT,
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                       FOREIGN KEY (category_id) REFERENCES category(id) ON DELETE SET NULL
);

CREATE TABLE favorites (
                           id INT AUTO_INCREMENT PRIMARY KEY,
                           movie_id INT NOT NULL,
                           added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                           FOREIGN KEY (movie_id) REFERENCES movie(id) ON DELETE CASCADE,
                           UNIQUE KEY unique_favorite (movie_id)
);

-- =============================================
-- SAMPLE DATA
-- =============================================

INSERT INTO category (name) VALUES
                                ('Δράση'),
                                ('Κωμωδία'),
                                ('Δραματική'),
                                ('Επιστημονική Φαντασία'),
                                ('Θρίλερ'),
                                ('Τρόμου'),
                                ('Περιπέτεια'),
                                ('Ρομαντική');

INSERT INTO movie (title, description, duration_minutes, rating, release_year, release_month, image_url, category_id) VALUES
                                                                                                                          ('The Dark Knight', 'Ο Batman αντιμετωπίζει τον Joker, έναν εγκληματία που σπέρνει το χάος στο Gotham City.', 152, 9.0, 2008, 7, 'https://image.tmdb.org/t/p/w500/bTOmCkefIK8YNhQNe3IOSueYGNZ.jpg', 1),
                                                                                                                          ('Inception', 'Ένας κλέφτης που κλέβει εταιρικά μυστικά μέσω ονείρων καλείται να κάνει το αντίστροφο.', 148, 8.8, 2010, 7, 'https://image.tmdb.org/t/p/w500/ojCYOPJNUPGs9ZRrOkG08OXBQ9o.jpg', 4),
                                                                                                                          ('The Hangover', 'Τρεις φίλοι ξυπνούν μετά από ένα πάρτι στο Λας Βέγκας χωρίς να θυμούνται τίποτα.', 100, 7.7, 2009, 6, 'https://image.tmdb.org/t/p/w500/A0uS9rHR56FeBtpjVki16M5xxSW.jpg', 2),
                                                                                                                          ('Forrest Gump', 'Η ζωή ενός απλού ανθρώπου από την Αλαμπάμα που γίνεται μάρτυρας ιστορικών γεγονότων.', 142, 8.8, 1994, 7, 'https://image.tmdb.org/t/p/w500/2xFsMrXqpZzslJ38zif0oI3GZg.jpg', 3),
                                                                                                                          ('Interstellar', 'Μια ομάδα αστροναυτών ταξιδεύει μέσα από μια σκουληκότρυπα αναζητώντας νέο σπίτι για την ανθρωπότητα.', 169, 8.6, 2014, 11, 'https://image.tmdb.org/t/p/w500/o0xb7oUWC8K516QdYISRg57fFJv.jpg', 4),
                                                                                                                          ('The Silence of the Lambs', 'Μια νέα FBI πράκτορας συνεργάζεται με έναν κανίβαλο ψυχίατρο για να συλλάβει άλλον δολοφόνο.', 118, 8.6, 1991, 2, 'https://image.tmdb.org/t/p/w500/uS9m8OBk1A8eM9I042bx8XXpqAq.jpg', 5),
                                                                                                                          ('Home Alone', 'Ένα 8χρονο αγόρι μένει μόνο στο σπίτι τα Χριστούγεννα και αντιμετωπίζει δύο ληστές.', 103, 7.7, 1990, 11, 'https://image.tmdb.org/t/p/w500/pxhBATxBCDIAFluEBap8da4spBz.jpg', 2),
                                                                                                                          ('Titanic', 'Μια ερωτική ιστορία ανάμεσα σε δύο νέους διαφορετικής κοινωνικής τάξης πάνω στο διάσημο πλοίο.', 195, 7.9, 1997, 12, 'https://image.tmdb.org/t/p/w500/pebkcUSKUOWZWiA86MuW1YoiGIz.jpg', 8),
                                                                                                                          ('The Matrix', 'Ένας χάκερ ανακαλύπτει ότι η πραγματικότητα δεν είναι αυτό που νομίζει.', 136, 8.7, 1999, 3, 'https://image.tmdb.org/t/p/w500/aOIuZAjPaRIE6CMzbazvcHuHXDc.jpg', 4),
                                                                                                                          ('Gladiator', 'Ένας Ρωμαίος στρατηγός γίνεται σκλάβος και μονομάχος αναζητώντας εκδίκηση.', 155, 8.5, 2000, 5, 'https://image.tmdb.org/t/p/w500/mnOh92ehc5niuJVwSm60ibmOOYv.jpg', 1),
                                                                                                                          ('The Shining', 'Ένας συγγραφέας μεταφέρεται με την οικογένειά του σε ένα απομακρυσμένο ξενοδοχείο για χειμερινή φύλαξη.', 146, 8.4, 1980, 5, 'https://image.tmdb.org/t/p/w500/7BYi8Mst51iiCFiYx0TUaYtnlnh.jpg', 6),
                                                                                                                          ('Pulp Fiction', 'Ιστορίες εγκλήματος και βίας στο Λος Άντζελες που διασταυρώνονται με απρόσμενους τρόπους.', 154, 8.9, 1994, 10, 'https://image.tmdb.org/t/p/w500/u2gYbehZhUgjga8QFk8M0hAXrKU.jpg', 5),
                                                                                                                          ('Indiana Jones', 'Ένας αρχαιολόγος-περιπετειώδης ταξιδεύει τον κόσμο αναζητώντας αρχαία αντικείμενα.', 115, 8.4, 1981, 6, 'https://image.tmdb.org/t/p/w500/aubslfLGASRmWzFI3LINHQuy1Kf.jpg', 7),
                                                                                                                          ('The Notebook', 'Μια αιώνια ερωτική ιστορία ανάμεσα σε δύο νέους διαφορετικής κοινωνικής τάξης.', 123, 7.8, 2004, 6, 'https://image.tmdb.org/t/p/w500/rMSjkqgVoszViqTdDgNyj0NB7AT.jpg', 8),
                                                                                                                          ('Avengers: Endgame', 'Οι Avengers προσπαθούν να αναιρέσουν τις πράξεις του Thanos μετά τον αφανισμό του μισού σύμπαντος.', 181, 8.4, 2019, 4, 'https://image.tmdb.org/t/p/w500/nAMWcCVH6RZczERv6ATD6aJlPUP.jpg', 1),
                                                                                                                          ('Die Hard', 'Ένας αστυνομικός προσπαθεί να σώσει ομήρους από έναν ουρανοξύστη που έχει καταληφθεί από τρομοκράτες.', 132, 8.2, 1988, 7, 'https://image.tmdb.org/t/p/w500/yFihWxQcmqcaBR31QM6Y8gT6aYV.jpg', 1),
                                                                                                                          ('Terminator 2: Judgment Day', 'Ένας Terminator από το μέλλον στέλνεται να προστατέψει έναν νεαρό που θα γίνει ηγέτης της ανθρώπινης αντίστασης.', 137, 8.5, 1991, 7, 'https://image.tmdb.org/t/p/original/dPw6Nq8CgCKMjU8T5VJTRVqfH93.jpg', 1),
                                                                                                                          ('Braveheart', 'Ο Σκωτσέζος πολεμιστής William Wallace ηγείται εξέγερσης κατά της αγγλικής κατοχής και κυριαρχίας.', 178, 8.3, 1995, 5, 'https://image.tmdb.org/t/p/w500/or1gBugydmjToAEq7OZY0owwFk.jpg', 1),
                                                                                                                          ('Mad Max: Fury Road', 'Σε μια μεταποκαλυπτική έρημο, ένας άνδρας βοηθά μια ομάδα γυναικών να ξεφύγουν από έναν τύραννο.', 120, 8.1, 2015, 5, 'https://image.tmdb.org/t/p/w500/hA2ple9q4qnwxp3hKVNhroipsir.jpg', 1),
                                                                                                                          ('Scarface', 'Ένας Κουβανός μετανάστης ανεβαίνει στα ύψη του υποκόσμου της Φλόριντα μέσα από βία και αμοραλισμό.', 170, 8.3, 1983, 12, 'https://image.tmdb.org/t/p/w500/iQ5ztdjvteGeboxtmRdXEChJOHh.jpg', 1),
                                                                                                                          ('Toy Story', 'Τα παιχνίδια ενός αγοριού ζωντανεύουν όταν δεν υπάρχουν άνθρωποι γύρω και αντιμετωπίζουν κοινές περιπέτειες.', 81, 8.3, 1995, 11, 'https://image.tmdb.org/t/p/w500/uXDfjJbdP4ijW5hWSBrPrlKpxab.jpg', 2),
                                                                                                                          ('The Grand Budapest Hotel', 'Ο θρυλικός concierge ενός ξενοδοχείου και ο νεαρός βοηθός του εμπλέκονται σε μυστήριο, κλοπή και δολοφονία.', 99, 8.1, 2014, 3, 'https://image.tmdb.org/t/p/original/zXaCOluyoW4GHIEghANFifWaT1c.jpg', 2),
                                                                                                                          ('Mrs. Doubtfire', 'Ένας πατέρας μεταμφιέζεται σε γυναίκα οικιακή βοηθό για να μπορεί να βλέπει τα παιδιά του μετά το διαζύγιο.', 125, 7.0, 1993, 11, 'https://image.tmdb.org/t/p/original/vwFv4AqhAID9tNk6clVAcVnPjJp.jpg', 2),
                                                                                                                          ('The Shawshank Redemption', 'Ένας αθώος άνδρας βρίσκει ελπίδα και ανθρωπιά μέσα στις φυλακές Shawshank κατά τη διάρκεια αρκετών δεκαετιών.', 142, 9.3, 1994, 9, 'https://image.tmdb.org/t/p/w500/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg', 3),
                                                                                                                          ('The Godfather', 'Η ιστορία της οικογένειας Corleone, μιας ισχυρής μαφιόζικης δυναστείας στη μεταπολεμική Αμερική.', 175, 9.2, 1972, 3, 'https://image.tmdb.org/t/p/original/4O9yjPMtiCphfuleKtP9B7BEsXv.jpg', 3),
                                                                                                                          ('Schindler''s List', 'Ο Γερμανός επιχειρηματίας Όσκαρ Σίντλερ σώζει χιλιάδες Εβραίους από τα ναζιστικά στρατόπεδα κατά τη διάρκεια του Ολοκαυτώματος.', 195, 9.0, 1993, 12, 'https://image.tmdb.org/t/p/w500/sF1U4EUQS8YHUYjNl3pMGNIQyr0.jpg', 3),
                                                                                                                          ('Goodfellas', 'Η άνοδος και η πτώση ενός νεαρού που εντάσσεται στον κόσμο του οργανωμένου εγκλήματος στη Νέα Υόρκη.', 146, 8.7, 1990, 9, 'https://image.tmdb.org/t/p/w500/aKuFiU82s5ISJpGZp7YkIr3kCUd.jpg', 3),
                                                                                                                          ('Saving Private Ryan', 'Μια ομάδα Αμερικανών στρατιωτών στέλνεται στη Νορμανδία για να βρει και να επαναπατρίσει έναν νεαρό στρατιώτη.', 169, 8.6, 1998, 7, 'https://image.tmdb.org/t/p/w500/1wY4psJ5NVEhCuOYROwLH2XExM2.jpg', 3),
                                                                                                                          ('Whiplash', 'Ένας νεαρός τυμπανιστής αντιμετωπίζει έναν εξαιρετικά απαιτητικό δάσκαλο μουσικής σε μια ελίτ σχολή.', 107, 8.5, 2014, 10, 'https://image.tmdb.org/t/p/w500/7fn624j5lj3xTme2SgiLCeuedmO.jpg', 3),
                                                                                                                          ('The Truman Show', 'Ένας άνδρας ανακαλύπτει ότι η ζωή του είναι στην πραγματικότητα ένα reality show που μεταδίδεται σε όλο τον κόσμο.', 103, 8.1, 1998, 6, 'https://image.tmdb.org/t/p/original/yFFrETGXDLQR78Tto3kIO6PVGeI.jpg', 3),
                                                                                                                          ('1917', 'Δύο νεαροί Βρετανοί στρατιώτες λαμβάνουν μια αδύνατη αποστολή για να σταματήσουν μια επίθεση στα χαρακώματα του Α'' Παγκοσμίου Πολέμου.', 119, 8.2, 2019, 12, 'https://image.tmdb.org/t/p/original/1EHZ9CGOdlUg71U4o7LVI8ADiGb.jpg', 3),
                                                                                                                          ('Back to the Future', 'Ένας έφηβος ταξιδεύει κατά λάθος πίσω στο 1955 χρησιμοποιώντας ένα αυτοκίνητο-χρονομηχανή που κατασκεύασε ο εκκεντρικός φίλος του.', 116, 8.5, 1985, 7, 'https://image.tmdb.org/t/p/w500/fNOH9f1aA7XRTzl1sAOx9iF553Q.jpg', 4),
                                                                                                                          ('Blade Runner 2049', 'Ένας νέος blade runner ανακαλύπτει ένα μυστικό που θα μπορούσε να ανατρέψει την κοινωνική τάξη.', 164, 8.0, 2017, 10, 'https://image.tmdb.org/t/p/w500/gajva2L0rPYkEWjzgFlBXCAVBE5.jpg', 4),
                                                                                                                          ('Dune', 'Ο νεαρός Paul Atreides ταξιδεύει στον επικίνδυνο πλανήτη Arrakis για να εξασφαλίσει το πολυτιμότερο αγαθό του σύμπαντος.', 155, 8.0, 2021, 10, 'https://image.tmdb.org/t/p/original/nYkNFpkwLR9s2XsIj3HCB06KvI5.jpg', 4),
                                                                                                                          ('2001: A Space Odyssey', 'Ένα ταξίδι από την αυγή της ανθρωπότητας μέχρι μια αποστολή στον Δία, με φόντο την εξέλιξη της τεχνητής νοημοσύνης.', 149, 8.3, 1968, 4, 'https://image.tmdb.org/t/p/original/aIQToAwRmdtRyvxEXeZtVQWJHUy.jpg', 4),
                                                                                                                          ('Fight Club', 'Ένας άυπνος γραφειοκράτης και ένας σαπωνοποιός ιδρύουν έναν μυστικό σύλλογο πυγμαχίας που εξελίσσεται σε κάτι πολύ πιο σκοτεινό.', 139, 8.8, 1999, 10, 'https://image.tmdb.org/t/p/w500/bptfVGEQuv6vDTIMVCHjJ9Dz8PX.jpg', 5),
                                                                                                                          ('Se7en', 'Δύο ντετέκτιβ κυνηγούν έναν σειριακό δολοφόνο που σκοτώνει τα θύματά του βασισμένος στα επτά θανάσιμα αμαρτήματα.', 127, 8.6, 1995, 9, 'https://image.tmdb.org/t/p/w500/69Sns8WoET6CfaYlIkHbla4l7nC.jpg', 5),
                                                                                                                          ('The Sixth Sense', 'Ένας νεαρός που βλέπει νεκρούς ζητά τη βοήθεια ενός παιδοψυχολόγου για να αντιμετωπίσει το χάρισμά του.', 107, 8.1, 1999, 8, 'https://image.tmdb.org/t/p/w500/ljsZTbVsrQSqZgWeep2B1QiDKuh.jpg', 5),
                                                                                                                          ('No Country for Old Men', 'Ένας κυνηγός βρίσκει χρήματα από ναρκωτικά και βρίσκεται να τον κυνηγά ένας ανελέητος επαγγελματίας δολοφόνος.', 122, 8.2, 2007, 11, 'https://image.tmdb.org/t/p/original/cflv3S88BA66VI5yMTT5SfX7JB3.jpg', 5),
                                                                                                                          ('Parasite', 'Μια φτωχή κορεατική οικογένεια σχεδιάζει με πονηριά τον τρόπο να διεισδύσει στη ζωή μιας πλούσιας οικογένειας.', 132, 8.5, 2019, 5, 'https://image.tmdb.org/t/p/w500/7IiTTgloJzvGI1TAYymCfbfl3vT.jpg', 5),
                                                                                                                          ('Joker', 'Ο Arthur Fleck, ένας αποτυχημένος κωμικός στο Γκόθαμ, μετατρέπεται σταδιακά στον διάσημο κακοποιό Joker.', 122, 8.4, 2019, 10, 'https://image.tmdb.org/t/p/w500/udDclJoHjfjb8Ekgsd4FDteOkCU.jpg', 5),
                                                                                                                          ('Alien', 'Το πλήρωμα ενός εμπορικού διαστημόπλοιου αντιμετωπίζει ένα θανατηφόρο εξωγήινο πλάσμα μέσα στο πλοίο.', 117, 8.4, 1979, 5, 'https://image.tmdb.org/t/p/original/8WhClCPb4NNyyG37Y9q4g9bLCjw.jpg', 6),
                                                                                                                          ('The Exorcist', 'Η μητέρα ενός νεαρού κοριτσιού ζητά τη βοήθεια δύο ιερέων όταν υποψιάζεται ότι η κόρη της έχει καταληφθεί από δαίμονα.', 122, 8.1, 1973, 12, 'https://image.tmdb.org/t/p/original/2ykBXgXBQbs2nfPTfMG60bvY4Vz.jpg', 6),
                                                                                                                          ('Halloween', 'Ένας ψυχοπαθής δολοφόνος ξεφεύγει από ψυχιατρείο και επιστρέφει στην πόλη του για να στοιχειώσει εφήβους.', 91, 7.7, 1978, 10, 'https://image.tmdb.org/t/p/original/d62YzdOrC4LfObyb2q1qGVxUvID.jpg', 6),
                                                                                                                          ('Get Out', 'Ένας νεαρός Αφροαμερικανός επισκέπτεται τους γονείς της λευκής φίλης του και αρχίζει να αποκαλύπτει σκοτεινά μυστικά.', 104, 7.7, 2017, 2, 'https://image.tmdb.org/t/p/w500/tFXcEccSQMf3lfhfXKSU9iRBpa3.jpg', 6),
                                                                                                                          ('Jurassic Park', 'Ένας επιστήμονας δημιουργεί ένα θεματικό πάρκο με αναβιωμένους δεινόσαυρους που ξεφεύγουν από τον έλεγχό τους.', 127, 8.1, 1993, 6, 'https://image.tmdb.org/t/p/w500/oU7Oq2kFAAlGqbU4VoAE36g4hoI.jpg', 7),
                                                                                                                          ('The Lion King', 'Ο νεαρός λιοντάρι Simba εξορίζεται από το βασίλειό του και πρέπει να επιστρέψει για να ανακτήσει τη θέση που του ανήκει.', 88, 8.5, 1994, 6, 'https://image.tmdb.org/t/p/original/oKtUXpv9GLY09UKMpUKPgo0nzhx.jpg', 7),
                                                                                                                          ('Pirates of the Caribbean: The Curse of the Black Pearl', 'Ο ιδιόρρυθμος πειρατής Καπετάν Jack Sparrow βοηθά έναν νεαρό σιδηρουργό να σώσει την αγαπημένη του από καταραμένους πειρατές.', 143, 7.9, 2003, 7, 'https://image.tmdb.org/t/p/w500/z8onk7LV9Mmw6zKz4hT6pzzvmvl.jpg', 7),
                                                                                                                          ('The Lord of the Rings: The Fellowship of the Ring', 'Ο νεαρός Hobbit Frodo ξεκινά επικό ταξίδι μαζί με έναν σύντροφο από εννέα ήρωες για να καταστρέψει ένα παντοδύναμο δαχτυλίδι.', 178, 8.8, 2001, 12, 'https://image.tmdb.org/t/p/w500/6oom5QYQ2yQTMJIbnvbkBL9cHo6.jpg', 7),
                                                                                                                          ('La La Land', 'Ένας τζαζίστας και μια ηθοποιός ερωτεύονται ενώ κυνηγούν τα όνειρά τους στο Λος Άντζελες.', 128, 8.0, 2016, 12, 'https://image.tmdb.org/t/p/original/5yCZrZT4REVfYhNczVyWk5593aZ.jpg', 8);
