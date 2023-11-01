<script>
import { sliceEvents, createPlugin } from '@fullcalendar/core';
import moment from 'moment';

export default createPlugin({
    views: {
        premium: {
            class: ['premium'], // Fix the typo here (change 'classs' to 'class')
            type: 'weekGrid',
            duration: { days: 7 },
            buttonText: 'pre',
            content: function (props) {
                // Define a function to generate an array of dates between two given dates
                function generateDateArray(startDate, endDate) {
                    const dateArr = [];
                    let currentDate = new Date(startDate);

                    while (currentDate <= endDate) {
                        dateArr.push(moment(currentDate).format('MM-DD-YYYY')); // Use 'MM-DD-YYYY' format
                        currentDate.setDate(currentDate.getDate() + 1);
                    }

                    return dateArr;
                }
                // Adjust the number of days as needed
                const prevDate = moment(props.dateProfile.activeRange.start);
                /// try to subtract 1 day vc
                const nextDate = moment(props.dateProfile.activeRange.end).add(1, 'month');
                const startDate = moment(prevDate).format('MM-DD-YYYY');
                const endDate = moment(nextDate).format('MM-DD-YYYY');

                const dateArr = generateDateArray(new Date(startDate), new Date(endDate));

                let segs = sliceEvents(props, true); // allDay=true

                // Create an object to store day information
                const main = {
                    days: {},
                };

                const daysOfWeek = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];

                for (const day of daysOfWeek) {
                    const dateIndex = daysOfWeek.indexOf(day);
                    const date = dateArr[dateIndex];

                    main.days[day] = {
                        date: date,
                        events: Object.values(props.eventStore.defs).filter((eventItem) => {
                            const eventDay = moment(eventItem.extendedProps.dateFrom).format('dddd');
                            const eventDate = moment(eventItem.extendedProps.dateFrom).format('MM-DD-YYYY');

                            return eventDay === day && eventDate === date; // Compare eventDate with date
                        }),
                    };
                }

                // Sort events within each day by date
                for (const day in main.days) {
                    if (main.days.hasOwnProperty(day)) {
                        main.days[day].events.sort((eventA, eventB) => {
                            const dateA = moment(eventA.extendedProps.dateFrom);
                            const dateB = moment(eventB.extendedProps.dateFrom);
                            return dateA - dateB;
                        });
                    }
                }

                // Create the HTML content
                let eventsHtml = '';
                let html = `
<div class="cl-calendar">
  <div class="timeline">
    <!-- Your timeline markers go here -->
  </div>
  <div class="days">
`;

                // Loop through each day in main.days and generate HTML
                for (const day in main.days) {
                    if (main.days.hasOwnProperty(day)) {
                        const dayInfo = main.days[day];
                        const dateNum = dayInfo.date;
                        const dayName = day;

                        const eventHtml = dayInfo.events
                            .map((eventItem) => `
<div class="event start-10 end-12 corp-fi">
  <p class="title">${eventItem.title}</p>
  <p class="dateFrom">${eventItem.extendedProps.dateFrom}</p>
</div>
`)
                            .join('');

                        html += `
  <div class="day ${day.toLowerCase()}">
    <div class="date">
      <p class="date-num">${moment(dateNum).format('DD')}</p>
      <p class="date-day">${dayName}</p>
    </div>
    <div class="events">
    ${eventHtml}
    </div>
  </div>
  `;

                        eventsHtml += eventHtml; // Concatenate event HTML for all days
                    }
                }

                html += `
  </div>
</div>
`;
console.log(main)
                return { html: html, eventsHtml: eventsHtml }; // Return the HTML content
            },
        },
    },
});

</script>


<style lang="css">
:root {
    --numDays: 5;
    --numHours: 10;
    --timeHeight: 60px;
    --calBgColor: #e8baba;
    --eventBorderColor: #f2d3d8;
    --eventColor1: #ffd6d1;
    --eventColor2: #fafaa3;
    --eventColor3: #e2f8ff;
    --eventColor4: #d1ffe6;
}

.cl-calendar {
    display: grid;
    gap: 10px;
    grid-template-columns: auto 1fr;
    margin: 2rem;
}

.dateTop {
    display: flex;
    justify-content: center;
}

.timeline {
    display: grid;
    grid-template-rows: repeat(var(--numHours), var(--timeHeight));
}

.days {
    display: grid;
    grid-column: 2;
    gap: 5px;
    grid-template-columns: repeat(auto-fit, minmax(112px, 1fr));
}

.events {
    display: grid;
    height: auto;
    grid-template-rows: repeat(var(--numHours), var(--timeHeight));
    border-radius: 5px;
    background: var(--calBgColor);
}

// Place on Timeline
.start-10 {
    grid-row-start: 2;
}

.start-12 {
    grid-row-start: 4;
}

.start-1 {
    grid-row-start: 5;
}

.start-2 {
    grid-row-start: 6;
}

.end-12 {
    grid-row-end: 4;
}

.end-1 {
    grid-row-end: 5;
}

.end-3 {
    grid-row-end: 7;
}

.end-4 {
    grid-row-end: 8;
}

.end-5 {
    grid-row-end: 9;
}

// Event

.title {
    font-weight: 600;
    margin-bottom: 0.25rem;
}

.event {
    border: 1px solid var(--eventBorderColor);
    border-radius: 5px;
    padding: 0.2rem;
    margin: 0 0.2rem;
    height: auto;
    background: white;
}
.dateFrom{
    font-size: 0.5rem;
}
.space,
.date {
    height: 60px
}

// Global / Etc

body {
    font-family: system-ui, sans-serif;
}

.corp-fi {
    background: var(--eventColor1);
}

.ent-law {
    background: var(--eventColor2);
}

.writing {
    background: var(--eventColor3);
}

.securities {
    background: var(--eventColor4);
}

.date {
    display: flex;
    gap: 1em;
}

.date-num {
    font-size: 3rem;
    font-weight: 600;
    display: inline;
}

.date-day {
    display: inline;
    font-size: 1rem;
    font-weight: 100;
}
</style>
