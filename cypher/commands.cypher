CREATE (:Game{ name:'Call of Duty: WWII', year:'2017' });
CREATE (:Game{ name:'Call of Duty: Advanced Warfare', year:'2014' });
CREATE (:Game{ name:'Cuphead', genre:'Run and Gun', year:'2017' });
CREATE (:Game{ name:'Assassin\'s Creed Origins', year:'2017' });
CREATE (:Game{ name:'DOOM', year:'2016' });
CREATE (:Game{ name:'The Elder Scrolls V: Skyrim - Special Edition', year:'2011' });
CREATE (:Game{ name:'The Witcher 3: Wild Hunt', year:'2015' });

CREATE (:Genre{ name:'FPS' });
CREATE (:Genre{ name:'Run and Gun' });
CREATE (:Genre{ name:'Adventure' });
CREATE (:Genre{ name:'Stealth' });
CREATE (:Genre{ name:'RPG' });

MATCH (a:Game{ name:'Call of Duty: WWII' }), (b:Genre{ name:'FPS' }) CREATE (a)-[r:BelongsTo]->(b);
MATCH (a:Game{ name:'Call of Duty: Advanced Warfare' }), (b:Genre{ name:'FPS' }) CREATE (a)-[r:BelongsTo]->(b);
MATCH (a:Game{ name:'DOOM' }), (b:Genre{ name:'FPS' }) CREATE (a)-[r:BelongsTo]->(b);
MATCH (a:Game{ name:'Cuphead' }), (b:Genre{ name:'Run and Gun' }) CREATE (a)-[r:BelongsTo]->(b);
MATCH (a:Game{ name:'Assassin\'s Creed Origins' }), (b:Genre{ name:'Adventure' }) CREATE (a)-[r:BelongsTo]->(b);
MATCH (a:Game{ name:'Assassin\'s Creed Origins' }), (b:Genre{ name:'Stealth' }) CREATE (a)-[r:BelongsTo]->(b);
MATCH (a:Game{ name:'Assassin\'s Creed Origins' }), (b:Genre{ name:'RPG' }) CREATE (a)-[r:BelongsTo]->(b);
MATCH (a:Game{ name:'The Elder Scrolls V: Skyrim - Special Edition' }), (b:Genre{ name:'RPG' }) CREATE (a)-[r:BelongsTo]->(b);
MATCH (a:Game{ name:'The Witcher 3: Wild Hunt' }), (b:Genre{ name:'RPG' }) CREATE (a)-[r:BelongsTo]->(b);
MATCH (a:Game{ name:'The Witcher 3: Wild Hunt' }), (b:Genre{ name:'Adventure' }) CREATE (a)-[r:BelongsTo]->(b);

CREATE (:Producer{ name:'Sledgehammer Games', country:'United States of America', city:'Foster City' });
CREATE (:Producer:Publisher{ name:'Studio MDHR', country:'Canada', city:'Oakville' });
CREATE (:Producer{ name:'Ubisoft Montreal', country:'Canada', city:'Montreal' });
CREATE (:Producer{ name:'id Software', country:'United States of America', city:'Mesquite' });
CREATE (:Producer{ name:'Bethesda Game Studios', country:'United States of America', city:'Rockville' });
CREATE (:Producer{ name:'CD Projekt RED', country:'Poland', city:'Warsaw' });

MATCH (a:Game{ name:'Call of Duty: WWII' }), (b:Producer{ name:'Sledgehammer Games' }) CREATE (a)-[r:CreatedBy]->(b);
MATCH (a:Game{ name:'Call of Duty: Advanced Warfare' }), (b:Producer{ name:'Sledgehammer Games' }) CREATE (a)-[r:CreatedBy]->(b);
MATCH (a:Game{ name:'Cuphead' }), (b:Producer:Publisher{ name:'Studio MDHR' }) CREATE (a)-[r:CreatedBy]->(b);
MATCH (a:Game{ name:'Assassin\'s Creed Origins' }), (b:Producer{ name:'Ubisoft Montreal' }) CREATE (a)-[r:CreatedBy]->(b);
MATCH (a:Game{ name:'DOOM' }), (b:Producer{ name:'id Software' }) CREATE (a)-[r:CreatedBy]->(b);
MATCH (a:Game{ name:'The Elder Scrolls V: Skyrim - Special Edition' }), (b:Producer{ name:'Bethesda Game Studios' }) CREATE (a)-[r:CreatedBy]->(b);
MATCH (a:Game{ name:'The Witcher 3: Wild Hunt' }), (b:Producer{ name:'CD Projekt RED' }) CREATE (a)-[r:CreatedBy]->(b);

CREATE (:Publisher{ name:'Activision Blizzard', country:'United States of America', city:'Santa Monica' });
CREATE (:Publisher{ name:'Ubisoft', country:'France', city:'Rennes' });
CREATE (:Publisher{ name:'Bethesda Softworks', country:'United States of America', city:'Rockville' });
CREATE (:Publisher{ name:'CD Projekt', country:'Poland', city:'Warsaw' });

MATCH (a:Game{ name:'Call of Duty: WWII' }), (b:Publisher{ name:'Activision Blizzard' }) CREATE (a)-[r:PublishedBy{ date:'03-11-2017' }]->(b);
MATCH (a:Game{ name:'Call of Duty: Advanced Warfare' }), (b:Publisher{ name:'Activision Blizzard' }) CREATE (a)-[r:PublishedBy{ date:'04-11-2014' }]->(b);
MATCH (a:Game{ name:'Cuphead' }), (b:Producer:Publisher{ name:'Studio MDHR' }) CREATE (a)-[r:PublishedBy{ date:'29-10-2017' }]->(b);
MATCH (a:Game{ name:'Assassin\'s Creed Origins' }), (b:Publisher{ name:'Ubisoft' }) CREATE (a)-[r:PublishedBy{ date:'27-10-2017' }]->(b);
MATCH (a:Game{ name:'DOOM' }), (b:Publisher{ name:'Bethesda Softworks' }) CREATE (a)-[r:PublishedBy{ date:'13-05-2016' }]->(b);
MATCH (a:Game{ name:'The Elder Scrolls V: Skyrim - Special Edition' }), (b:Publisher{ name:'Bethesda Softworks' }) CREATE (a)-[r:PublishedBy{ date:'11-11-2011' }]->(b);
MATCH (a:Game{ name:'The Witcher 3: Wild Hunt' }), (b:Publisher{ name:'CD Projekt' }) CREATE (a)-[r:PublishedBy{ date:'19-05-2015' }]->(b);

CREATE (:Platform{ name:'PC' });
CREATE (:Platform{ name:'PS4' });
CREATE (:Platform{ name:'XONE' });

MATCH (a:Platform{ name:'PC' }), (b:Game) CREATE (b)-[r:AvailableOn]->(a);
MATCH (a:Platform{ name:'XONE' }), (b:Game) CREATE (b)-[r:AvailableOn]->(a);
MATCH (a:Platform{ name:'PS4' }), (b:Game) WHERE b.name <> 'Cuphead' CREATE (b)-[r:AvailableOn]->(a);