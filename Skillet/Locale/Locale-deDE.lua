--[[

Skillet: A tradeskill window replacement.
Copyright (c) 2007 Robert Clark <nogudnik@gmail.com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

]]--

-- German localizations provided by Farook (from wowinterface.com) and Stan (from wowace)

-- If you are doing localization and would like your name added here, please feel free
-- to do so, or let me know and I will be happy to add you to the credits
--[[
2009-10-14, RaverJK:
I did a complete review and proof reading  of the German translation. I changed a lot.
Many terms have been shortened to have the lables more intuitive and the descriptions
more... erm..  descriptive.
]]--

local L = LibStub("AceLocale-3.0"):NewLocale("Skillet", "deDE")
if not L then return end

L[" days"] = " Tage"
L["ABOUTDESC"] = "Gibt Informationen über Skillet aus"
L["APPEARANCEDESC"] = "Einstellungen, die das Aussehen von Skillet ändern" -- Needs review
L["About"] = "Über Skillet"
L["Appearance"] = "Aussehen"
L["Blizzard"] = "Blizzard"
L["Buy Reagents"] = "Reagenzien kaufen"
L["By Difficulty"] = "Nach Schwierigkeit"
L["By Item Level"] = "Nach Item-Level"
L["By Level"] = "Nach Stufe"
L["By Name"] = "Nach Name"
L["By Quality"] = "Nach Qualität"
L["By Skill Level"] = "Nach Schwierigkeitsgrad"
L["CONFIGDESC"] = "Öffnet ein Konfigurationsfenster für Skillet"
L["Clear"] = "Leeren"
L["Collapse all groups"] = "Alle Gruppe einklappen"
L["Config"] = "Konfiguraton"
L["Could not find bag space for"] = "Kann keinen Taschenplatz finden für"
L["Crafted By"] = "Herstellbar von"
L["Create"] = "Erstellen"
L["Create All"] = "Alle erstellen"
L["DISPLAYREQUIREDLEVELDESC"] = "Wenn der hergestellte Gegenstand eine Charakter-Mindeststufe erfordert, wird die Stufe im Rezept angezeigt"
L["DISPLAYREQUIREDLEVELNAME"] = "Zeige benötigte Stufe"
L["DISPLAYSGOPPINGLISTATAUCTIONDESC"] = "Zeigt eine Liste der in deinen Taschen fehlenden Ragenzien, die für die Herstellung der Gegenstände in der Warteschlange benötigt werden."
L["DISPLAYSGOPPINGLISTATAUCTIONNAME"] = "Einkaufsliste im Auktionshaus"
L["DISPLAYSHOPPINGLISTATBANKDESC"] = "Zeigt eine Liste der in deinen Taschen fehlenden Ragenzien, die für die Herstellung der Gegenstände in der Warteschlange benötigt werden."
L["DISPLAYSHOPPINGLISTATBANKNAME"] = "Einkaufsliste in der Bank"
L["DISPLAYSHOPPINGLISTATGUILDBANKDESC"] = "Eine Einkaufsliste von Gegenständen anzeigen die benötigt werden um bereits in Auftrag gegebene Rezepte zu erstellen, sich aber nicht in deinen Taschen befinden"
L["DISPLAYSHOPPINGLISTATGUILDBANKNAME"] = "Einkaufsliste an der Gildenbank anzeigen"
L["Delete"] = "Löschen"
L["ENHANCHEDRECIPEDISPLAYDESC"] = "When aktiviert, werden an Rezeptnamen ein oder mehrere '+'  angehängt, in Abhängigkeit von der Schwierigkeit des Rezepts"
L["ENHANCHEDRECIPEDISPLAYNAME"] = "Rezeptschwierigkeit als Text anzeigen"
L["Enabled"] = "Aktiviert"
L["Enchant"] = "Verzaubern"
L["Expand all groups"] = "Alle Gruppen ausklappen"
L["FEATURESDESC"] = "Optionale Funktionen die ein- oder ausgeschaltet werden können."
L["Features"] = "Optionen"
L["Filter"] = "Filter"
L["Glyph "] = "Glyphe "
L["Gold earned"] = "Erhaltenes Gold"
L["Grouping"] = "Gruppierung"
L["Hide trivial"] = "Graue verstecken"
L["Hide uncraftable"] = "Nur herstellbare"
L["INVENTORYDESC"] = "Inventar-Information"
L["Include alts"] = "Twinks miteinbeziehen"
L["Inventory"] = "Inventar"
L["LINKCRAFTABLEREAGENTSDESC"] = "Wenn ein Reagenz für das aktuelle Rezept hergestellt werden kann, führt ein Klick auf das Reagenz zu dessen Rezept."
L["LINKCRAFTABLEREAGENTSNAME"] = "Reagenzien anklickbar"
L["Library"] = "Bibliothek"
L["Load"] = "Laden"
L["Move Down"] = "Nach unten"
L["Move Up"] = "Nach oben"
L["Move to Bottom"] = "Warteschlange umordnen"
L["Move to Top"] = "Nach oben"
L["No Data"] = "Keine Daten"
L["No such queue saved"] = "Keine solche Warteschlange gespeichert"
L["None"] = "Nichts"
L["Notes"] = "Notizen"
L["Number of items to queue/create"] = "Anzahl der Gegenstände in Warteschlange/zum Erstellen"
L["Options"] = "Optionen"
L["Pause"] = "Pause"
L["Process"] = "Start!"
L["Purchased"] = "Eingekauft"
L["QUEUECRAFTABLEREAGENTSDESC"] = "Wenn ein Reagenz für das aktuelle Rezept hergestellt werden kann aber nicht genug fertige davon da sind, wird das Reagenz zur Warteschlange hinzugefügt."
L["QUEUECRAFTABLEREAGENTSNAME"] = "Herstellbare Reagenzien zur Warteschlange"
L["QUEUEGLYPHREAGENTSDESC"] = "Wenn du eine benötigte Zutat für das derzeitige Rezept herstellen kannst, von dem du zu wenig hast, dann wird diese Zutat zur Warteschlange hinzugefügt. Diese Option ist speziell für Glyphen." -- Needs review
L["QUEUEGLYPHREAGENTSNAME"] = "Zutaten für Glyphen in Warteschlange" -- Needs review
L["Queue"] = "Warteschlange"
L["Queue All"] = "Alle in Warteschlange"
L["Queue is empty"] = "Warteschlange ist leer"
L["Queue is not empty. Overwrite?"] = "Warteschlange ist nicht leer. Überschreiben?"
L["Queue with this name already exsists. Overwrite?"] = "Eine Warteschlange mit diesem Namen besteht bereits. Überschreiben?"
L["Queues"] = "Warteschlangen"
L["Really delete this queue?"] = "Diese Warteschlange tatsächlich löschen?"
L["Rescan"] = "Erneut scannen"
L["Retrieve"] = "Abfragen"
L["SCALEDESC"] = "Skalierung des Berufsfensters (Standard 1.0)"
L["SHOPPINGLISTDESC"] = "Zeigt die Einkaufsliste"
L["SHOWBANKALTCOUNTSDESC"] = "Beim Berechnen und Darstellen der Anzahl herstellbarer Gegenstände, die Gegenstände in der Bank und deiner anderen Charaktere berücksichtigen"
L["SHOWBANKALTCOUNTSNAME"] = "Bankfächer und andere Chars inkludieren"
L["SHOWCRAFTCOUNTSDESC"] = "Anzahl der Herstellungsvorgänge anzeigen, statt der Anzahl der hergestellten Gegenstände"
L["SHOWCRAFTCOUNTSNAME"] = "Anzeigen der herstellbaren Anzahl"
L["SHOWCRAFTERSTOOLTIPDESC"] = "Zeigt im Tooltip eines Gegenstandes die Twinks an, die ihn herstellen können."
L["SHOWCRAFTERSTOOLTIPNAME"] = "Hersteller im Tooltip anzeigen"
L["SHOWDETAILEDRECIPETOOLTIPDESC"] = "Zeigt einen detaillierten Tooltip, wenn der Mauszeiger über ein Rezept auf der linken Seite gehalten wird."
L["SHOWDETAILEDRECIPETOOLTIPNAME"] = "Detaillierter Tooltip für Rezepte"
L["SHOWFULLTOOLTIPDESC"] = "Zeige alle Informationen über den herzustellenden Gegenstand. Wenn es abgeschaltet ist, sieht man nur den zusammengefassten Tooltip (Strg halten für den kompletten Tooltip)" -- Needs review
L["SHOWFULLTOOLTIPNAME"] = "Standard-Tooltips verwenden"
L["SHOWITEMNOTESTOOLTIPDESC"] = "Zeigt die benutzerdefinierten Notizen für einen Gegenstand im Tooltip an."
L["SHOWITEMNOTESTOOLTIPNAME"] = "Notizen im Tooltip"
L["SHOWITEMTOOLTIPDESC"] = "Anzeige des hergestellten Gegenstandes, statt des Rezepts"
L["SHOWITEMTOOLTIPNAME"] = "Den Gegenstandstooltip anzeigen wenn möglich"
L["SORTASC"] = "Sortiere aufsteigend"
L["SORTDESC"] = "Sortiere absteigend"
L["STANDBYDESC"] = "Standby-Modus ein/ausschalten"
L["STANDBYNAME"] = "standby"
L["SUPPORTEDADDONSDESC"] = "Unterstützte Addons die Dazu benutzt werden könnten oder benutzt werden um das Inventar aufzuzeichnen."
L["Save"] = "Speichern"
L["Scale"] = "Skalierung"
L["Scan completed"] = "Scan abgeschlossen"
L["Scanning tradeskill"] = "Scanne Berufe"
L["Select skill difficulty threshold"] = "Select skill difficulty threshold"
L["Selected Addon"] = "Gewähltes Addon"
L["Sells for "] = "Verkauf für "
L["Shopping List"] = "Einkaufsliste"
L["Skillet Trade Skills"] = "Skillet Trade Skills"
L["Skipping"] = "Überspringe"
L["Sold amount"] = "verkaufte Menge"
L["Sorting"] = "Sortierung"
L["Source:"] = "Quelle:"
L["Start"] = "Start"
L["Supported Addons"] = "Unterstützte Addons"
L["TRANSPARAENCYDESC"] = "Transparenz des Skillet-Fensters"
L["This merchant sells reagents you need!"] = "Dieser Händler verkauft Reagenzien die du brauchst!"
L["Total Cost:"] = "Gesamtkosten:"
L["Total spent"] = "Ausgegeben total"
L["Trained"] = "Erlernt"
L["Transparency"] = "Transparenz"
L["Unknown"] = "Unbekannt"
L["VENDORAUTOBUYDESC"] = "Hat ein Händler Reagenzien, die in der Einkaufsliste sind, werden diese automatisch gekauft."
L["VENDORAUTOBUYNAME"] = "Reagenzien automatisch kaufen"
L["VENDORBUYBUTTONDESC"] = "Hat ein Händler Reagenzien, die in der Einkaufsliste sind, wird eine Schaltfläche zum Kaufen der Reagenzien angezeigt."
L["VENDORBUYBUTTONNAME"] = "Kaufen-Schaltfläche beim Händler"
L["View Crafters"] = "View Crafters" -- Requires localization
L["alts"] = "Reagenzien auf Twinks"
L["bank"] = "Reagenzien in der Bank"
L["buyable"] = "käuflich"
L["can be created from reagents in your inventory"] = "herstellbar mit den Reagenzien in deinem Inventar"
L["can be created from reagents in your inventory and bank"] = "herstellbar mit den Reagenzien in deinem Inventar und der Bank"
L["can be created from reagents on all characters"] = "herstellbar mit den Reagenzien auf allen Charakteren"
L["click here to add a note"] = "Hier klicken um eine Notiz hinzuzufügen"
L["craftable"] = "herstellbar"
L["have"] = "hat" -- Needs review
L["is now disabled"] = "ist jetzt deaktiviert"
L["is now enabled"] = "ist jetzt aktiviert"
L["need"] = "benötigt"
L["not yet cached"] = "noch nicht im Cache"
L["reagents in inventory"] = "Reagenzien im Inventar"

