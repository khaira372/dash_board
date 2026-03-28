// ==========================================
// GLOBAL STATE
// ==========================================
var charts = {};
var currentData = {};
var map = null;

// ==========================================
// MOCK DATA
// ==========================================
var MOCK_WILAYAS = [
    { id: 1, code: '01', nom_fr: 'Adrar' },
    { id: 2, code: '02', nom_fr: 'Chlef' },
    { id: 9, code: '09', nom_fr: 'Blida' },
    { id: 14, code: '14', nom_fr: 'Tiaret' },
    { id: 16, code: '16', nom_fr: 'Alger' },
    { id: 25, code: '25', nom_fr: 'Constantine' },
    { id: 31, code: '31', nom_fr: 'Oran' },
    { id: 35, code: '35', nom_fr: 'Boumerdès' },
    { id: 42, code: '42', nom_fr: 'Tipaza' },
    { id: 44, code: '44', nom_fr: 'Aïn Defla' }
];

var MOCK_COMMUNES = {
    1:  [{ id: 101, nom_fr: 'Adrar' }, { id: 102, nom_fr: 'Reggane' }, { id: 103, nom_fr: 'Timimoun' }],
    2:  [{ id: 201, nom_fr: 'Chlef' }, { id: 202, nom_fr: 'Ténès' }, { id: 203, nom_fr: 'El Karimia' }],
    9:  [{ id: 901, nom_fr: 'Blida' }, { id: 902, nom_fr: 'Boufarik' }, { id: 903, nom_fr: 'Mouzaïa' }],
    14: [{ id: 1401, nom_fr: 'Tiaret' }, { id: 1402, nom_fr: 'Sougueur' }, { id: 1403, nom_fr: 'Frenda' }, { id: 1404, nom_fr: 'Mahdia' }],
    16: [{ id: 1601, nom_fr: 'Alger Centre' }, { id: 1602, nom_fr: 'Bab El Oued' }, { id: 1603, nom_fr: 'Birtouta' }],
    25: [{ id: 2501, nom_fr: 'Constantine' }, { id: 2502, nom_fr: 'El Khroub' }, { id: 2503, nom_fr: 'Hamma Bouziane' }],
    31: [{ id: 3101, nom_fr: 'Oran' }, { id: 3102, nom_fr: 'Aïn Türk' }, { id: 3103, nom_fr: 'Es Sénia' }],
    35: [{ id: 3501, nom_fr: 'Boumerdès' }, { id: 3502, nom_fr: 'Bordj Ménaïel' }],
    42: [{ id: 4201, nom_fr: 'Tipaza' }, { id: 4202, nom_fr: 'Cherchell' }],
    44: [{ id: 4401, nom_fr: 'Aïn Defla' }, { id: 4402, nom_fr: 'Miliana' }]
};

var MOCK_STATS = {
    total_exploitations: 1245,
    total_exploitants: 1180,
    total_sau: 45680,
    surface_irriguee: 12350,
    statuts: [
        { nom_fr: 'Personne physique', count: 650 },
        { nom_fr: 'SARL', count: 320 },
        { nom_fr: 'Coopérative', count: 180 },
        { nom_fr: 'EURL', count: 95 }
    ]
};

var MOCK_EXPLOITATIONS = (function () {
    var noms = ['Benali', 'Kaci', 'Bouzid', 'Zerrouki', 'Hamidi', 'Mebarki', 'Boudiaf', 'Larbi', 'Slimani', 'Ferhat'];
    var wilayas = ['Tiaret', 'Alger', 'Oran', 'Blida', 'Constantine'];
    var communes = ['Tiaret', 'Sougueur', 'Frenda', 'Mahdia', 'Birtouta', 'Es Sénia', 'El Khroub', 'Boufarik'];
    var activites = ['Végétale', 'Animale', 'Mixte'];
    var arr = [];
    for (var i = 0; i < 15; i++) {
        arr.push({
            id: i + 1,
            nom_exploitation_fr: 'Ferme ' + noms[i % noms.length],
            exploitant_nom: noms[i % noms.length],
            exploitant_prenom: ['Mohamed', 'Ahmed', 'Ali', 'Youcef', 'Karim'][i % 5],
            wilaya: wilayas[i % wilayas.length],
            commune: communes[i % communes.length],
            superficie_totale: +(20 + Math.random() * 100).toFixed(1),
            activite: activites[i % 3],
            activite_id: (i % 3) + 1,
            latitude: 35.0 + Math.random() * 1.5,
            longitude: 1.0 + Math.random() * 2.5
        });
    }
    return arr;
})();

var MOCK_CULTURES = [
    { nom: 'Blé dur', surface: 1500 },
    { nom: 'Orge', surface: 1200 },
    { nom: 'Luzerne', surface: 800 },
    { nom: 'Pomme de terre', surface: 650 },
    { nom: 'Oignon', surface: 480 },
    { nom: 'Tomate', surface: 420 },
    { nom: 'Oliviers', surface: 380 },
    { nom: 'Agrumes', surface: 310 },
    { nom: 'Vignes', surface: 250 },
    { nom: 'Palmier dattier', surface: 200 }
];

var MOCK_CHEPTEL = [
    { nom: 'Ovins', total: 12500 },
    { nom: 'Bovins', total: 3800 },
    { nom: 'Caprins', total: 2600 },
    { nom: 'Volaille', total: 45000 },
    { nom: 'Équins', total: 420 }
];

// ==========================================
// INITIALIZATION
// ==========================================
document.addEventListener('DOMContentLoaded', function () {
    loadWilayas();
    updateDashboard();
    initMap();
});

// ==========================================
// FILTER FUNCTIONS
// ==========================================
function loadWilayas() {
    var select = document.getElementById('wilayaFilter');
    MOCK_WILAYAS.forEach(function (w) {
        var opt = document.createElement('option');
        opt.value = w.id;
        opt.textContent = w.code + ' - ' + w.nom_fr;
        select.appendChild(opt);
    });
}

function loadCommunes() {
    var wilayaId = document.getElementById('wilayaFilter').value;
    var select = document.getElementById('communeFilter');
    select.innerHTML = '<option value="">Toutes</option>';
    if (!wilayaId) return;
    var communes = MOCK_COMMUNES[wilayaId] || [];
    communes.forEach(function (c) {
        var opt = document.createElement('option');
        opt.value = c.id;
        opt.textContent = c.nom_fr;
        select.appendChild(opt);
    });
}

function refreshData() {
    updateDashboard();
}

// ==========================================
// DASHBOARD UPDATE
// ==========================================
function updateDashboard() {
    updateKPICards(MOCK_STATS);
    updateStatutChart(MOCK_STATS.statuts);
    updateLandUseChart();
    updateCulturesChart(MOCK_CULTURES);
    updateCheptelChart(MOCK_CHEPTEL);
    updateExploitationsTable(MOCK_EXPLOITATIONS);
    updateCulturesSectionCharts();
    updateElevageSectionCharts();
    updateInfrastructureCharts();
    updateMap(MOCK_EXPLOITATIONS);
}

// ==========================================
// KPI CARDS
// ==========================================
function updateKPICards(stats) {
    animateNumber('totalExploitations', stats.total_exploitations);
    animateNumber('totalExploitants', stats.total_exploitants);
    animateNumber('totalSAU', stats.total_sau);
    var rate = stats.total_sau > 0 ? ((stats.surface_irriguee / stats.total_sau) * 100).toFixed(1) : '0';
    document.getElementById('irrigationRate').textContent = rate + '%';
}

function animateNumber(elementId, target) {
    var el = document.getElementById(elementId);
    if (!el) return;
    var duration = 800;
    var steps = 50;
    var increment = target / steps;
    var current = 0;
    var stepTime = duration / steps;
    var timer = setInterval(function () {
        current += increment;
        if (current >= target) {
            current = target;
            clearInterval(timer);
        }
        el.textContent = Math.floor(current).toLocaleString();
    }, stepTime);
}

// ==========================================
// CHART HELPERS
// ==========================================
function getChartCanvas(id) {
    if (charts[id]) {
        charts[id].destroy();
        delete charts[id];
    }
    return document.getElementById(id);
}

// ==========================================
// DASHBOARD CHARTS
// ==========================================

// 1. Statut Juridique (Doughnut)
function updateStatutChart(statuts) {
    var ctx = getChartCanvas('statutChart');
    if (!ctx) return;
    charts.statutChart = new Chart(ctx, {
        type: 'doughnut',
        data: {
            labels: statuts.map(function (s) { return s.nom_fr; }),
            datasets: [{
                data: statuts.map(function (s) { return s.count; }),
                backgroundColor: ['#4caf50', '#2196f3', '#ff9800', '#9c27b0'],
                borderWidth: 2,
                borderColor: '#fff'
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: true,
            plugins: {
                legend: { position: 'bottom', labels: { padding: 15, font: { size: 11 } } }
            },
            cutout: '60%'
        }
    });
}

// 2. Land Use (Stacked Bar)
function updateLandUseChart() {
    var ctx = getChartCanvas('landUseChart');
    if (!ctx) return;
    charts.landUseChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: ['Cultures herbacées', 'Terres en jachère', 'Cultures pérennes', 'Prairies naturelles'],
            datasets: [
                { label: 'Sec', data: [1200, 800, 600, 400], backgroundColor: '#ff9800', stack: 'Stack 0' },
                { label: 'Irrigué', data: [800, 0, 400, 100], backgroundColor: '#2196f3', stack: 'Stack 0' }
            ]
        },
        options: {
            responsive: true,
            scales: {
                x: { stacked: true },
                y: { stacked: true, title: { display: true, text: 'Hectares' } }
            }
        }
    });
}

// 3. Cultures (Horizontal Bar)
function updateCulturesChart(cultures) {
    var ctx = getChartCanvas('culturesChart');
    if (!ctx) return;
    charts.culturesChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: cultures.map(function (c) { return c.nom; }),
            datasets: [{
                label: 'Surface (ha)',
                data: cultures.map(function (c) { return c.surface; }),
                backgroundColor: '#4caf50',
                borderRadius: 4
            }]
        },
        options: {
            indexAxis: 'y',
            responsive: true,
            plugins: { legend: { display: false } }
        }
    });
}

// 4. Cheptel (Pie)
function updateCheptelChart(cheptel) {
    var ctx = getChartCanvas('cheptelChart');
    if (!ctx) return;
    charts.cheptelChart = new Chart(ctx, {
        type: 'pie',
        data: {
            labels: cheptel.map(function (c) { return c.nom; }),
            datasets: [{
                data: cheptel.map(function (c) { return c.total; }),
                backgroundColor: ['#ff9800', '#4caf50', '#2196f3', '#9c27b0', '#f44336']
            }]
        },
        options: {
            responsive: true,
            plugins: { legend: { position: 'right' } }
        }
    });
}

// ==========================================
// CULTURES SECTION CHARTS
// ==========================================
function updateCulturesSectionCharts() {
    // Category chart
    var ctx1 = getChartCanvas('categorieCultureChart');
    if (ctx1) {
        charts.categorieCultureChart = new Chart(ctx1, {
            type: 'bar',
            data: {
                labels: ['Céréales', 'Légumineuses', 'Maraîchage', 'Arboriculture', 'Fourragères'],
                datasets: [{
                    label: 'Surface (ha)',
                    data: [2700, 450, 1550, 940, 800],
                    backgroundColor: ['#4caf50', '#ff9800', '#2196f3', '#9c27b0', '#795548']
                }]
            },
            options: { responsive: true, plugins: { legend: { display: false } } }
        });
    }

    // Irrigation chart
    var ctx2 = getChartCanvas('irrigationChart');
    if (ctx2) {
        charts.irrigationChart = new Chart(ctx2, {
            type: 'doughnut',
            data: {
                labels: ['Irrigué', 'Sec (pluvial)'],
                datasets: [{
                    data: [12350, 33330],
                    backgroundColor: ['#2196f3', '#ff9800'],
                    borderWidth: 2,
                    borderColor: '#fff'
                }]
            },
            options: {
                responsive: true,
                cutout: '55%',
                plugins: { legend: { position: 'bottom' } }
            }
        });
    }
}

// ==========================================
// ÉLEVAGE SECTION
// ==========================================
function updateElevageSectionCharts() {
    var ctx = getChartCanvas('detailCheptelChart');
    if (ctx) {
        charts.detailCheptelChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: ['Ovins', 'Bovins', 'Caprins', 'Volaille', 'Équins', 'Apiculture (ruches)'],
                datasets: [{
                    label: 'Effectif',
                    data: [12500, 3800, 2600, 45000, 420, 850],
                    backgroundColor: ['#ff9800', '#4caf50', '#2196f3', '#9c27b0', '#795548', '#ffc107']
                }]
            },
            options: {
                responsive: true,
                plugins: { legend: { display: false } },
                scales: { y: { title: { display: true, text: 'Nombre de têtes' } } }
            }
        });
    }

    // Elevage KPI cards
    var container = document.getElementById('elevageKPIs');
    if (container) {
        container.innerHTML = [
            { label: 'Total Ovins', value: '12 500' },
            { label: 'Total Bovins', value: '3 800' },
            { label: 'Total Caprins', value: '2 600' },
            { label: 'Total Volaille', value: '45 000' }
        ].map(function (kpi) {
            return '<div class="elevage-kpi-card"><h4>' + kpi.label + '</h4><div class="value">' + kpi.value + '</div></div>';
        }).join('');
    }
}

// ==========================================
// INFRASTRUCTURE SECTION
// ==========================================
function updateInfrastructureCharts() {
    var ctx1 = getChartCanvas('batimentsChart');
    if (ctx1) {
        charts.batimentsChart = new Chart(ctx1, {
            type: 'bar',
            data: {
                labels: ['Étables', 'Bergeries', 'Poulaillers', 'Hangars', 'Silos', 'Serres'],
                datasets: [{
                    label: 'Nombre',
                    data: [320, 480, 210, 560, 85, 140],
                    backgroundColor: '#4caf50',
                    borderRadius: 4
                }]
            },
            options: { responsive: true, plugins: { legend: { display: false } } }
        });
    }

    var ctx2 = getChartCanvas('materielChart');
    if (ctx2) {
        charts.materielChart = new Chart(ctx2, {
            type: 'doughnut',
            data: {
                labels: ['Tracteurs', 'Moissonneuses', 'Charrues', 'Pulvérisateurs', 'Remorques'],
                datasets: [{
                    data: [680, 120, 950, 340, 510],
                    backgroundColor: ['#4caf50', '#2196f3', '#ff9800', '#9c27b0', '#795548'],
                    borderWidth: 2,
                    borderColor: '#fff'
                }]
            },
            options: {
                responsive: true,
                cutout: '55%',
                plugins: { legend: { position: 'bottom', labels: { font: { size: 11 } } } }
            }
        });
    }
}

// ==========================================
// EXPLOITATIONS TABLE
// ==========================================
function updateExploitationsTable(exploitations) {
    var tbody = document.getElementById('exploitationsBody');
    if (!tbody) return;
    tbody.innerHTML = '';
    exploitations.forEach(function (expl) {
        var row = tbody.insertRow();
        var actClass = expl.activite.toLowerCase();
        row.innerHTML =
            '<td>' + expl.id + '</td>' +
            '<td>' + expl.nom_exploitation_fr + '</td>' +
            '<td>' + expl.exploitant_nom + '</td>' +
            '<td>' + expl.wilaya + '</td>' +
            '<td>' + expl.commune + '</td>' +
            '<td>' + expl.superficie_totale + ' ha</td>' +
            '<td><span class="badge ' + actClass + '">' + expl.activite + '</span></td>' +
            '<td><button onclick="showDetails(' + expl.id + ')"><i class="fas fa-eye"></i> Voir</button></td>';
    });
}

function filterExploitations() {
    var search = document.getElementById('searchExploitation').value.toLowerCase();
    var rows = document.querySelectorAll('#exploitationsBody tr');
    rows.forEach(function (row) {
        row.style.display = row.textContent.toLowerCase().includes(search) ? '' : 'none';
    });
}

// ==========================================
// MAP
// ==========================================
function initMap() {
    var container = document.getElementById('mapContainer');
    if (!container || map) return;
    map = L.map('mapContainer').setView([35.0, 3.0], 6);
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: '&copy; OpenStreetMap contributors'
    }).addTo(map);
}

function updateMap(exploitations) {
    if (!map) return;
    map.eachLayer(function (layer) {
        if (layer instanceof L.Marker || layer instanceof L.CircleMarker) map.removeLayer(layer);
    });
    exploitations.forEach(function (expl) {
        if (expl.latitude && expl.longitude) {
            var color = expl.activite_id === 1 ? '#4caf50' : expl.activite_id === 2 ? '#ff9800' : '#2196f3';
            var marker = L.circleMarker([expl.latitude, expl.longitude], {
                radius: 8, fillColor: color, color: '#fff', weight: 2, opacity: 1, fillOpacity: 0.8
            }).addTo(map);
            marker.bindPopup(
                '<b>' + expl.nom_exploitation_fr + '</b><br>' +
                'Exploitant: ' + expl.exploitant_nom + '<br>' +
                'Superficie: ' + expl.superficie_totale + ' ha'
            );
        }
    });
}

// ==========================================
// NAVIGATION
// ==========================================
function showSection(sectionId, clickedEl) {
    document.querySelectorAll('.section').forEach(function (sec) {
        sec.classList.remove('active');
    });
    var target = document.getElementById(sectionId);
    if (target) target.classList.add('active');

    document.querySelectorAll('.nav-links li').forEach(function (li) {
        li.classList.remove('active');
    });
    if (clickedEl) clickedEl.classList.add('active');

    if (sectionId === 'map' && map) {
        setTimeout(function () { map.invalidateSize(); }, 150);
    }
}

// ==========================================
// MODAL
// ==========================================
function showDetails(id) {
    var expl = MOCK_EXPLOITATIONS.find(function (e) { return e.id === id; });
    if (!expl) return;

    var body = document.getElementById('modalBody');
    body.innerHTML =
        '<div class="detail-grid">' +
        '<div class="detail-item"><label>Nom:</label><span>' + expl.nom_exploitation_fr + '</span></div>' +
        '<div class="detail-item"><label>Exploitant:</label><span>' + expl.exploitant_nom + ' ' + expl.exploitant_prenom + '</span></div>' +
        '<div class="detail-item"><label>Wilaya:</label><span>' + expl.wilaya + '</span></div>' +
        '<div class="detail-item"><label>Commune:</label><span>' + expl.commune + '</span></div>' +
        '<div class="detail-item"><label>Superficie:</label><span>' + expl.superficie_totale + ' ha</span></div>' +
        '<div class="detail-item"><label>Activité:</label><span>' + expl.activite + '</span></div>' +
        '<div class="detail-item"><label>Latitude:</label><span>' + expl.latitude.toFixed(4) + '</span></div>' +
        '<div class="detail-item"><label>Longitude:</label><span>' + expl.longitude.toFixed(4) + '</span></div>' +
        '</div>';

    document.getElementById('detailModal').style.display = 'block';
}

function closeModal() {
    document.getElementById('detailModal').style.display = 'none';
}

window.addEventListener('click', function (e) {
    var modal = document.getElementById('detailModal');
    if (e.target === modal) modal.style.display = 'none';
});
