{% macro get_designation(column) %}

{%- set categories = {
    'PHARMACIE':             ['PHARMACIE', 'PHARMA', 'MEDICAMENT', 'PILULE', 'NICOTINIQUE',
                              'HOMEOPAT', 'SEVRAGE TABAC', 'PREP\.MAGIST', 'PREPA\.PHAR',
                              'PREPA\.MAGIST', 'TRAIT NICOTINIQUE', 'KIT PREVENTION'],
    'DENTAIRE':              ['DENT', 'STOMATOL', 'ORTHODONT', 'CHIRURGIE DENT', 'RADIO DENT', 'PROT\.DENT'],
    'OPTIQUE':               ['OPTIQUE', 'LENTILLE', 'LASER MYOPIE'],
    'HOSPITALISATION':       ['HOSPI', 'SEJOUR', 'F\.J\.', 'FRAIS SEJ', 'CHAMBRE',
                              'LIT ACCOMP', 'TELEVISION', 'PART\.ASS\.', 'PART\.FORFAIT'],
    'BIOLOGIE / ANALYSES':   ['BIOLOGIE', 'PRELEVEMENT', 'PRELEVT', 'PREL\.', 'LABO', 'ANATOMO', 'ANATO'],
    'RADIOLOGIE / IMAGERIE': ['RADIO', 'IMAGERIE', 'ECHO', 'SCANNER', 'DOPPLER', 'SCINTIGRAPH'],
    'TRANSPORT':             ['TRANSPORT', 'DEPLAC', 'DEPL\.', 'SMUR'],
    'MATERNITE / PEDIATRIE': ['SAGE', 'MATERNIT', 'NAISSANCE', 'POSTNATAL', 'IVG', 'PEDIATR', 'NOURRISSON'],
    'REEDUCATION':           ['KINE', 'ORTHOPHON', 'ORTHOPT', 'PEDICUR'],
    'SOINS INFIRMIERS':      ['INFIRM', 'PANSEMENT', 'SOINS INF'],
    'CONSULTATION':          ['CONSULT', 'VISITE'],
    'CHIRURGIE':             ['CHIRURGI', 'ANESTHES', 'IMPLANT', 'PROTHESE'],
    'PSYCHIATRIE / NEUROLOGIE': ['PSY', 'PSYCHIATR', 'NEUROPSYCH'],
    'CARDIOLOGIE':           ['CARDIO'],
    'DERMATOLOGIE':          ['DERMATO'],
    'MAJORATIONS / FORFAITS':['FORFAIT', 'MAJORATION', '^MAJ'],
    'APPAREILLAGE / MATERIEL':['APPAREIL', 'ORTHESE', 'DISPOSITIF', 'MAT\.ET APP',
                               'LOCAT\.', 'CONTENTION', 'ASSISTANCE RESPI'],
    'CURE THERMALE':         ['THERMALE', 'CURE'],
    'ACTES SPECIALISES':     ['ACTE', 'SOINS']
} -%}

CASE
    WHEN {{ column }} IS NULL THEN 'INCONNU'
    {% for categorie, patterns in categories.items() -%}
    WHEN UPPER(TRIM({{ column }})) ~ '{{ patterns | join("|") }}'
        THEN '{{ categorie }}'
    {% endfor -%}
    ELSE 'DIVERS'
END

{% endmacro %}